

resource "aws_iam_role" "lambda_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "example" {
  function_name = "samir-lambda-from-s3"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "python3.9"

  # 👇 Point to your S3 zip file
  s3_bucket     = "lambda-code-samir-s3"
  s3_key        = "lambda_function.zip"

  # Optional — to help Lambda detect changes
  #source_code_hash = filebase64sha256("lambda_function.zip")
}