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
