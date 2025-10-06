output "security_group_id" {
  description = "The ID of the created Security Group"
  value       = aws_security_group.main.id
}

output "security_group_name" {
  description = "The name of the created Security Group"
  value       = aws_security_group.main.name
}

output "security_group_arn" {
  description = "The ARN of the created Security Group"
  value       = aws_security_group.main.arn
}
