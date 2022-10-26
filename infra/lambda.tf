######################################################################
# Resources for Lambda Patching
######################################################################
# Zips the lamba source code to send it later
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambdas/mandingo_lambda.py"
  output_path = "${path.module}/lambdas/mandingo_lambda.zip"
}

# Creates the Lamda function
resource "aws_lambda_function" "mandingos" {
  filename         = "${path.module}/lambdas/mandingo_lambda.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_mandingos.arn
  handler          = "${var.lambda_function_name}.handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "python3.7"
  timeout          = "60"
}




######################################################################
# Resources for Lambda Patching
######################################################################
# Zips the lamba source code to send it later
data "archive_file" "mandingo_name_zip" {
  type        = "zip"
  source_file = "${path.module}/lambdas/mandingo_name.py"
  output_path = "${path.module}/lambdas/mandingo_name.zip"
}

# Creates the Lamda function
resource "aws_lambda_function" "mandingo_name" {
  filename         = "${path.module}/lambdas/mandingo_name.zip"
  function_name    = "mandingo_name"
  role             = aws_iam_role.lambda_mandingos.arn
  handler          = "mandingo_name.handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "python3.7"
  timeout          = "60"
}



