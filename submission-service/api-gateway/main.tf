resource "aws_api_gateway_rest_api" "impex-api" {
  name = "${var.api-name}"
}
resource "aws_api_gateway_resource" "impex-book-resource" {
  rest_api_id = aws_api_gateway_rest_api.impex-api.id
  parent_id   = aws_api_gateway_rest_api.impex-api.root_resource_id
  path_part   = "${var.endpoint_path}"
}
resource "aws_api_gateway_method" "impex-book" {
  rest_api_id   = aws_api_gateway_rest_api.impex-api.id
  resource_id   = aws_api_gateway_resource.impex-book-resource.id
  http_method   = "POST"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "impex-integration" {
  rest_api_id             = aws_api_gateway_rest_api.impex-api.id
  resource_id             = aws_api_gateway_resource.impex-book-resource.id
  http_method             = aws_api_gateway_method.impex-book.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${var.lambda-arn}"
}
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${var.submission-lambda-name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:us-east-1:266842636661:${aws_api_gateway_rest_api.impex-api.id}/*/${aws_api_gateway_method.impex-book.http_method}${aws_api_gateway_resource.impex-book-resource.path}"
}

resource "aws_api_gateway_deployment" "impex-dep" {
  rest_api_id = aws_api_gateway_rest_api.impex-api.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.impex-api.body))
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_api_gateway_method.impex-book, aws_api_gateway_integration.impex-integration]
}
resource "aws_api_gateway_stage" "impex" {
  deployment_id = aws_api_gateway_deployment.impex-dep.id
  rest_api_id   = aws_api_gateway_rest_api.impex-api.id
  stage_name    = "dev"
}