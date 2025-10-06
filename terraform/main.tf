module "vpc" {
  source = "./modules/vpc"

  vpc_cidr       = var.vpc_cidr
  public1_cidr   = var.public1_cidr
  public2_cidr   = var.public2_cidr
  private1_cidr  = var.private1_cidr
  private2_cidr  = var.private2_cidr
  az1            = var.az1
  az2            = var.az2
  nat1_eip       = var.nat1_eip
  nat2_eip       = var.nat2_eip
  project_name   = var.project_name
  tags           = var.tags
}


# IAM Role
resource "aws_iam_role" "auth_handler" {
  name = "one-journey-dev-test-authHandler-eu-west-1-lambdaRole"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    STAGE = "dev-test"
  }
}

resource "aws_iam_role_policy" "auth_handler_policy" {
  name = "one-journey-dev-test-lambda"
  role = "one-journey-dev-test-authHandler-eu-west-1-lambdaRole"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:eu-west-1:305905981536:log-group:/aws/lambda/one-journey-dev-test-authHandler:*:*"
      },
      {
        Effect = "Allow"
        Action = ["events:PutEvents"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem"
        ]
        Resource = [
          "arn:aws:dynamodb:eu-west-1:305905981536:table/one-journey-websockets-manager",
          "arn:aws:dynamodb:eu-west-1:305905981536:table/one-journey-workflow-context",
          "arn:aws:dynamodb:eu-west-1:305905981536:table/one-journey-sessions",
          "arn:aws:dynamodb:eu-west-1:305905981536:table/one-journey-common-objects"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "auth_handler_attach" {
  role       = aws_iam_role.auth_handler.name
  policy_arn = "arn:aws:iam::305905981536:role/one-journey-dev-test-authHandler-eu-west-1-lambdaRole"
}

resource "aws_iam_role_policy" "s3_policy" {
  name = "one-journey-dev-test-lambda"
  role = "one-journey-dev-test-coreS3Event-eu-west-1-lambdaRole"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:eu-west-1:305905981536:log-group:/aws/lambda/one-journey-dev-test-coreS3Event:*:*"
      },
      {
        Effect = "Allow"
        Action = ["events:PutEvents"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = ["sqs:*"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "states:StartExecution",
          "states:SendTaskSuccess"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = "arn:aws:s3:::*"
      },
      {
        Effect = "Allow"
        Action = [
          "ssm:PutParameter",
          "ssm:GetParameter",
          "ssm:DeleteParameter"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Resource = [
          "arn:aws:dynamodb:eu-west-1:305905981536:table/one-journey-common-objects",
          "arn:aws:dynamodb:eu-west-1:305905981536:table/one-journey-sessions",
          "arn:aws:dynamodb:eu-west-1:305905981536:table/one-journey-mutex-lock"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_attach" {
  role       = aws_iam_role.auth_handler.name
  policy_arn = "arn:aws:iam::305905981536:role/one-journey-dev-test-coreS3Event-eu-west-1-lambdaRole"
}

resource "aws_security_group" "main" {
  name        = "OJECSSecurityGroupLB-dev"
  description = "OJECSSecurityGroupLB-dev"
  vpc_id      = "vpc-07a8c9cc4874997d8"

  ingress {
    description = "Free Ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    OJ    = "OJ"
    STAGE = "dev"
  }
}

resource "aws_ecr_repository" "main" {
  name                 = "one-journey-repository-dev"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    OJ    = "OJ"
    STAGE = "dev"
  }
}

resource "aws_ecs_cluster" "main" {
  name = "OJCluster-dev"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }

  tags = {
    OJ    = "OJ"
    STAGE = "dev"
  }
}

module "s3_cf_templates" {
  source = "./modules/s3"

  bucket_name       = var.cf_templates_bucket_name
  force_destroy     = false
  owner_id          = var.owner_id
  versioning_status = "Disabled"
  sse_algorithm     = "AES256"
  bucket_key_enabled = false
  tags              = var.tags
}

module "s3_documents" {
  source = "./modules/s3"

  bucket_name       = var.documents_bucket_name
  force_destroy     = false
  owner_id          = var.owner_id
  versioning_status = "Disabled"
  sse_algorithm     = "AES256"
  bucket_key_enabled = false
  tags              = var.tags
}

variable "filename" {
  description = "Path to the Lambda deployment package (zip). If using S3, leave empty and set s3_bucket/s3_key instead."
  type        = string
  default     = "lambda.zip"
}

# Use the existing role ARN from your state
locals {
  lambda_role_arn = "arn:aws:iam::305905981536:role/one-journey-dev-test-talkJsWebhook-eu-west-1-lambdaRole"
}

resource "aws_lambda_function" "talkjs_webhook" {
  function_name = "one-journey-dev-test-talkJsWebhook"
  role          = local.lambda_role_arn
  handler       = "src/api/v1/channel/talkJs/webhook.handler"
  runtime       = "nodejs20.x"
  memory_size   = 1536
  timeout       = 6
  architectures = ["x86_64"]
  package_type  = "Zip"

  # If you have the zip locally (recommended in your case), set filename.
  # Ensure the file exists at the path specified by var.filename.
  filename         = var.filename
  source_code_hash = "XgzF+slHBd21U5AzVPFz3UCpIQTkM1DImYHFjlKLI0M="

  # If you instead want to deploy from S3, comment the two lines above and use:
  # s3_bucket = "your-bucket"
  # s3_key    = "path/to/your-lambda.zip"

  layers = [
    "arn:aws:lambda:eu-west-1:305905981536:layer:ffmpegv1:1"
  ]

  environment {
    variables = {
      ACCOUNT_ID                                  = "305905981536"
      API_ENDPOINT                                = "https://jy2hacoam9.execute-api.eu-west-1.amazonaws.com/dev-test/"
      AUDIOS_BUCKET                               = "one-journey-audiorecord-dev-test"
      CDN_ENDPOINT                                = "https://d2edzwz37badk2.cloudfront.net/"
      COGNITO_USER_POOL                           = "eu-west-1_dDvBEA3nb"
      COGNITO_USER_POOL_CLIENT                    = "5nqaq6r999704lta43ncu0m2ls"
      CORE_GDS_EVENT_ARN                          = "arn:aws:lambda:eu-west-1:305905981536:function:one-journey-dev-test-coreGDSEvent"
      CORE_S3_EVENT_ARN                           = "arn:aws:lambda:eu-west-1:305905981536:function:one-journey-dev-test-coreS3Event"
      CORS_ORIGIN                                 = "*"
      DEBUG_LOG                                   = "/aws/one-journey/one-journey-DebugLogs"
      DOMAIN_SUFFIX                               = "one-journey"
      DYNAMODB_TABLE_CHANNEL_MESSAGES             = "one-journey-channel-messages"
      DYNAMODB_TABLE_COMMON_OBJECTS               = "one-journey-common-objects"
      DYNAMODB_TABLE_COST                         = "one-journey-cost"
      DYNAMODB_TABLE_COUNTERS_STORAGE_CHANNEL     = "one-journey-counters-storage-channel"
      DYNAMODB_TABLE_EXECUTIONS                   = "one-journey-executions"
      DYNAMODB_TABLE_EXECUTIONS_V5                = "one-journey-executions-v5"
      DYNAMODB_TABLE_EXECUTIONS_V5_DETAIL         = "one-journey-executions-v5-detail"
      DYNAMODB_TABLE_EXECUTIONS_V5_GSI_CREATED_AT = "one-journey-executions-v5-gsi-createdAt"
      DYNAMODB_TABLE_EXECUTIONS_V5_GSI_UPDATED_AT = "one-journey-executions-v5-gsi-updatedAt"
      DYNAMODB_TABLE_GEN_AI_BATCH                 = "one-journey-genAIBatch"
      DYNAMODB_TABLE_MUTEX_LOCK                   = "one-journey-mutex-lock"
      DYNAMODB_TABLE_SESSIONS                     = "one-journey-sessions"
      DYNAMODB_TABLE_STT_OPERATIONS               = "one-journey-sttOperations"
      DYNAMODB_TABLE_SUSCRIPTIONS                 = "one-journey-suscriptions"
      DYNAMODB_TABLE_TEMPORARY                    = "one-journey-temporary-resources"
      DYNAMODB_TABLE_WEBSOCKETS_MANAGER           = "one-journey-websockets-manager"
      DYNAMODB_TABLE_WORKFLOWS_BACKUP             = "one-journey-workflows-backup"
      DYNAMODB_TABLE_WORKFLOW_CONTEXT             = "one-journey-workflow-context"
      ERROR_LOG                                   = "/aws/one-journey/one-journey-ErrorLogs"
      EVENTBRIDGE_MESSAGE_BUS                     = "one-journey-messages-bus-dev-test"
      HOSTING_BUCKET                              = "one-journey-hosting-bucket-dev-test"
      KENDRA_S3_ROLE_ARN                          = "arn:aws:iam::305905981536:role/OneJourneyKendraS3Role"
      KEYS_URL                                    = "https://cognito-idp.eu-west-1.amazonaws.com/eu-west-1_dDvBEA3nb/.well-known/jwks.json"
      MAIN_CONFIGURATION_ID                       = "@MAIN_CONFIGURATION"
      MAX_CHATGPT_RETRY_REQUEST                   = "5"
      ONE_JOURNEY_DATA_BUCKET                     = "one-journey-data-bucket-dev-test"
      ONE_JOURNEY_FILES_BUCKET                    = "one-journey-files-bucket-dev-test"
      PROCESS_TRANSCRIPTION_ARN                   = "arn:aws:lambda:eu-west-1:305905981536:function:one-journey-dev-test-processTranscription"
      REGION                                      = "eu-west-1"
      SQS_BATCH_QUEUE_URL                         = "https://sqs.eu-west-1.amazonaws.com/305905981536/one-journey-batch-queue-dev-test"
      STAGE                                       = "dev-test"
      STORAGE_PROCESS_LAMBDA_ARN                  = "arn:aws:lambda:eu-west-1:305905981536:function:one-journey-dev-test-manageFileStorage"
      STT_WEBHOOK_ARN                             = "arn:aws:lambda:eu-west-1:305905981536:function:one-journey-dev-test-sttWebhook"
      TRANSCRIPTIONS_BUCKET                       = "one-journey-transcriptions-dev-test"
      USER_POOL_CLIENT_ID                         = "5nqaq6r999704lta43ncu0m2ls"
      USER_POOL_ID                                = "eu-west-1_dDvBEA3nb"
      VERSION                                     = "v1"
      WEBSOCKET_API_ENDPOINT                      = "wss://r9kbm99j8b.execute-api.eu-west-1.amazonaws.com/dev-test/"
    }
  }

  ephemeral_storage {
    size = 512
  }

  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/one-journey-dev-test-talkJsWebhook"
  }

  tracing_config {
    mode = "PassThrough"
  }

  tags = {
    STAGE = "dev-test"
  }

  lifecycle {
    # keep Terraform from trying to replace the function because of AWS-managed fields
    ignore_changes = [
      # AWS-controlled attributes you don't manage here:
      last_modified,
      qualified_arn,
      version
    ]
  }

}




module "my_lambda" {
  source = "./lambda-module"

  function_name = "my-sample-lambda"
  handler       = "index.handler"
  filename      = "lambda.zip"
}


