# Konecta HandsOn Task - Terraform Infrastructure

This repository contains a modular Terraform configuration for importing and managing AWS infrastructure. The project demonstrates infrastructure-as-code best practices with a clean, modular architecture.

## 📋 Overview

This Terraform project is designed to import existing AWS infrastructure into Terraform state management, organizing resources across multiple modules for better maintainability and reusability.

## 🏗️ Architecture

The project follows a modular structure with the following components:

```
.
├── modules/
│   ├── iam/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ecs/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ecr/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── s3/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── provider.tf
```

## 📦 Modules

### IAM Module
Manages AWS Identity and Access Management resources including:
- IAM roles
- IAM policies
- IAM policy attachments
- Service-linked roles

### VPC Module
Handles Virtual Private Cloud networking components:
- VPC configuration
- Subnets (public/private)
- Internet Gateway
- NAT Gateway
- Route tables

### Security Group Module
Manages network security:
- Security groups
- Ingress/egress rules
- Network ACLs

### ECS Module
Manages Amazon Elastic Container Service resources:
- ECS clusters
- ECS services
- Task definitions
- Auto-scaling configurations

### ECR Module
Handles Amazon Elastic Container Registry:
- ECR repositories
- Repository policies
- Lifecycle policies

### S3 Module
Manages Amazon S3 storage:
- S3 buckets
- Bucket policies
- Versioning configuration
- Encryption settings

## 🚀 Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS CLI configured with appropriate credentials
- AWS account with necessary permissions

### Installation

1. Clone the repository:
```bash
git clone https://github.com/mohamedashrafz835/Konecta_HandsOn_Task_Terraform11.git
cd Konecta_HandsOn_Task_Terraform11
```

2. Initialize Terraform:
```bash
terraform init
```

3. Review the configuration:
```bash
terraform plan
```

4. Apply the configuration:
```bash
terraform apply
```

## 🔧 Configuration

### Provider Configuration

Configure your AWS provider in `provider.tf`:

```hcl
provider "aws" {
  region = var.aws_region
}
```

### Variables

Update `terraform.tfvars` with your specific values:

```hcl
aws_region = "us-east-1"
environment = "production"
# Add other variables as needed
```

### Importing Existing Resources

To import existing AWS resources into Terraform state:

```bash
# Example: Import an existing VPC
terraform import module.vpc.aws_vpc.main vpc-xxxxxxxxx

# Example: Import an existing S3 bucket
terraform import module.s3.aws_s3_bucket.main my-bucket-name

# Example: Import an ECS cluster
terraform import module.ecs.aws_ecs_cluster.main my-cluster-name
```

## 📝 Usage Examples

### Using Individual Modules

```hcl
module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr = "10.0.0.0/16"
  environment = var.environment
}

module "ecs" {
  source = "./modules/ecs"
  
  cluster_name = "my-ecs-cluster"
  vpc_id = module.vpc.vpc_id
}
```

## 🔐 Security Considerations

- Store sensitive variables in `terraform.tfvars` and add it to `.gitignore`
- Use AWS Secrets Manager or Parameter Store for sensitive data
- Enable encryption for S3 buckets and EBS volumes
- Follow the principle of least privilege for IAM roles
- Enable VPC Flow Logs for network monitoring

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👤 Author

**Mohamed Ashraf**
- GitHub: [@mohamedashrafz835](https://github.com/mohamedashrafz835)
- - GitHub: [@SherifAmino](https://github.com/SherifAmino)

## 🙏 Acknowledgments

- Konecta for the hands-on task opportunity
- Terraform community for excellent documentation
- AWS for comprehensive cloud services

## 📚 Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

## ⚠️ Notes

- Always run `terraform plan` before applying changes
- Keep your Terraform state file secure
- Use remote state backend (S3 + DynamoDB) for team collaboration
- Regularly update Terraform and provider versions

---

**Happy Infrastructure as Code! 🚀**
