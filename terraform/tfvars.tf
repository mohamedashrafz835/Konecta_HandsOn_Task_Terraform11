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

