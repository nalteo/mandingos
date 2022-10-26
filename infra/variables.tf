
# Lambda name to run the events coming from Event Bridge
variable "lambda_function_name" {
  type = string
  default = "mandingo_lambda"
}

# Lambda name to run the events coming from Event Bridge
variable "paching_lambda_reporting_function_name" {
  type = string
  default = "multi_account_patching_reporting"
}
