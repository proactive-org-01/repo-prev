resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL traffic"
  vpc_id      = "vpc-014f07ef478b8d29d"  # Replace with your VPC ID

  ingress {
    description = "MySQL access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For demo; restrict in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "rds-security-group"
    X-CS-Account = "547045142213"
    X-CS-Region = "us-east-1"
    Owner = "sneha"
    Reason = "template"
    Environment = "test"
  }

}

# Subnet group (use your subnet IDs)
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = ["subnet-4df6fb73", "subnet-079c9d4fb6784e4b4"]  
tags = {
    Name = "rds-subnet-group"
    X-CS-Account = "547045142213"
    X-CS-Region = "us-east-1"
    Owner = "sneha"
    Reason = "template"
    Environment = "test"
  }
}

# RDS Instance
resource "aws_db_instance" "rds_instance" {
  identifier              = "sneha-rds-demo"
  allocated_storage       = 20
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "Password123!"
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot     = true
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name

tags = {
    Name = "rds-subnet-group"
    X-CS-Account = "547045142213"
    X-CS-Region = "us-east-1"
    Owner = "sneha"
    Reason = "template"
    Environment = "test"
  }
}
