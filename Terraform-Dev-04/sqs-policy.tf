resource "aws_sqs_queue_policy" "impex_consumer_policy_deadqueue" {
  queue_url = aws_sqs_queue.impex_deadletter_queue.id
  policy      = data.aws_iam_policy_document.impex_consumer_policy_deadqueue.json
}


data "aws_iam_policy_document" "impex_consumer_policy_deadqueue" {
  statement {
    sid    = "Consumer Policy for Dead queue"
    principals {
      type        = "AWS"
      identifiers = ["266842636661"]
    }
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.impex_deadletter_queue.arn
    ]
  }
}


resource "aws_sqs_queue_policy" "impex_producer_policy" {
  queue_url = aws_sqs_queue.impex_sqs_queue.id
  policy      = data.aws_iam_policy_document.impex_producer_policy.json
}

data "aws_iam_policy_document" "impex_producer_policy" {
  statement {
    sid    = "Producer Policy for sqs queue"
    principals {
      type        = "AWS"
      identifiers = ["266842636661"]
    }
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:SendMessage"
    ]
    resources = [
      aws_sqs_queue.impex_sqs_queue.arn
    ]
  }
}