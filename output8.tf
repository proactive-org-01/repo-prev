output "instance_id" {
    value = aws_instance.web.ami
    }
output "instance_tags" {
    value = aws_instance.web.tags
    }