locals {
    lambda_zip_location = "outputs/impex.zip"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "impex.py"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "impex_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${local.lambda_zip_location}"
  function_name = "impex-lambda-function"
  role          = "${aws_iam_role.impex_lambda_role.arn}"
  handler       = "impex.hello"

  #source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.7"

}