# ------------------------
# VPC & Subnets
# ------------------------
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
}

# ------------------------
# DB Subnet Group
# ------------------------
resource "aws_db_subnet_group" "sub_grp" {
  name       = "mycutsubnett"
  subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

# ------------------------
# Primary RDS Instance
# ------------------------
resource "aws_db_instance" "default" {
  allocated_storage            = 10
  identifier                   = "samir-rds"
  db_name                      = "mydb"
  engine                       = "mysql"
  engine_version               = "8.0"
  instance_class               = "db.t3.micro"
  username                     = "admin"
   password                    = "samir123"
 
db_subnet_group_name         = aws_db_subnet_group.sub_grp.id
  parameter_group_name         = "default.mysql8.0"
  backup_retention_period      = 7
  backup_window                = "02:00-03:00"
  maintenance_window           = "sun:04:00-sun:05:00"
  deletion_protection          = false
  skip_final_snapshot          = true

  tags = {
    Name = "Primary-RDS"
  }
}

# ------------------------
# Read Replica
# ------------------------
resource "aws_db_instance" "read_replica" {
  identifier            = "samir-rds-replica"
  replicate_source_db   = aws_db_instance.default.arn
  instance_class        = "db.t3.micro"
  db_subnet_group_name  = aws_db_subnet_group.sub_grp.id
  skip_final_snapshot   = true
  deletion_protection   = false

  depends_on = [aws_db_instance.default]

  tags = {
    Name = "Read-Replica"
  }
}
