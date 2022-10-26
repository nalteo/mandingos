######################################################################
# Resources for Lambda Patching
######################################################################
# Zips the lamba source code to send it later
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambdas/mandingos.py"
  output_path = "${path.module}/lambdas/mandingos.zip"
}

# Creates the Lamda function
resource "aws_lambda_function" "mandingos" {
  filename         = "${path.module}/lambdas/mandingos.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_mandingos.arn
  handler          = "${var.lambda_function_name}.handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "python3.7"
  timeout          = "60"
}





