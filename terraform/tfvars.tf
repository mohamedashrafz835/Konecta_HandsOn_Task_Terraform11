vpc_cidr      = "10.133.56.0/25"
public1_cidr  = "10.133.56.64/27"
public2_cidr  = "10.133.56.96/27"
private1_cidr = "10.133.56.0/27"
private2_cidr = "10.133.56.32/27"

az1 = "eu-west-1a"
az2 = "eu-west-1b"

nat1_eip = "eipalloc-03c0f299953fa6cde"
nat2_eip = "eipalloc-0125eeaeeb3ed5378"

project_name = "ONE-Journey-Dev"

tags = {
  Country  = "Espana"
  Platform = "Terraform"
  Project  = "ONE Journey Dev"
}
cf_templates_bucket_name = "cf-templates-11mxdb199vu4y-eu-west-1"
documents_bucket_name    = "oj-docu1-khovrqxn9xyiwxtprdjmq"

owner_id = "e65b8be90b02e3c981860e80965f9ea93006d3a6431b4428f4d4c8ee1baf47bc"

tags = {
  Country  = "Espana"
  Platform = "Terraform"
  Project  = "ONE Journey Dev"
}
ecs_cluster_name       = "OJCluster-dev"
ecs_container_insights = "disabled"
ecs_tags = {
  OJ    = "OJ"
  STAGE = "dev"
}

ecr_name                 = "one-journey-repository-dev"
ecr_image_tag_mutability = "MUTABLE"
ecr_encryption_type      = "AES256"
ecr_scan_on_push         = false

ecr_tags = {
  OJ    = "OJ"
  STAGE = "dev"
}
sg_name        = "OJECSSecurityGroupLB-dev"
sg_description = "OJECSSecurityGroupLB-dev"
sg_vpc_id      = "vpc-07a8c9cc4874997d8"

sg_ingress_rules = [
  {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

sg_egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

sg_tags = {
  OJ    = "OJ"
  STAGE = "dev"
}

tags = {
  STAGE = "dev-test"
  OJ    = "OJ"
}

# --- Auth Handler Role ---
auth_handler_role_name = "one-journey-dev-test-authHandler-eu-west-1-lambdaRole"

auth_handler_assume_role_policy = jsonencode({
  Version = "2012-10-17"
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

auth_handler_policy_name = "one-journey-dev-test-lambda"

auth_handler_policy_document = jsonencode({
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

auth_handler_policy_arn = "arn:aws:iam::305905981536:role/one-journey-dev-test-authHandler-eu-west-1-lambdaRole"

# --- S3 Event Role ---
s3_role_name = "one-journey-dev-test-coreS3Event-eu-west-1-lambdaRole"

s3_assume_role_policy = jsonencode({
  Version = "2012-10-17"
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

s3_policy_name = "one-journey-dev-test-lambda"

s3_policy_document = jsonencode({
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

s3_policy_arn = "arn:aws:iam::305905981536:role/one-journey-dev-test-coreS3Event-eu-west-1-lambdaRole"
