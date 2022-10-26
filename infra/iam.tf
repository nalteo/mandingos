# Creates a role to allow lambda to trigger automation documents
resource "aws_iam_role" "lambda_mandingos" {
  name = "lambda_mandigos"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Creates the policy for the previous role
resource "aws_iam_policy" "lambda_mandingos_account_policy" {
  name        = "AWSLambdaSSMMultiAccountPatchingPolicy"
  path        = "/"
  description = "Allowed Lambda actions"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      Action = [ "s3:PutObject","s3:GetObject"]
      Resource = "*"
      Effect = "Allow"
      },
    ]

    })
}

# Attaches the policy to the previous role
resource "aws_iam_role_policy_attachment" "lambda_mandingos_policy_attachment" {
  role       = aws_iam_role.lambda_mandingos.name
  policy_arn = aws_iam_policy.lambda_mandingos_account_policy.arn
}