module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = "mandingo-rest"
  description   = "My awesome HTTP API Gateway"
  protocol_type = "HTTP"

  create_api_domain_name = false

  # Routes and integrations
  integrations = {
    "GET /name" = {
      lambda_arn = aws_lambda_function.mandingo_name.arn   
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }

    "POST /" = {
      lambda_arn             = aws_lambda_function.mandingos.arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }

  }

}





resource "aws_api_gateway_rest_api" "apiLambda" {
  description = "Example of an API Gateway"
  name        = "example"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "proxy" {
   rest_api_id = aws_api_gateway_rest_api.apiLambda.id
   parent_id   = aws_api_gateway_rest_api.apiLambda.root_resource_id
   path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxyMethod" {
   rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "ANY"
   authorization = "NONE"

}


resource "aws_api_gateway_integration" "lambda" {
   rest_api_id = aws_api_gateway_rest_api.apiLambda.id
   resource_id = aws_api_gateway_method.proxyMethod.resource_id
   http_method = aws_api_gateway_method.proxyMethod.http_method
   integration_http_method = "GET"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.mandingo_name.invoke_arn
}