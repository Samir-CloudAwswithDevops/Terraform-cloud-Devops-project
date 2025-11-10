provider "aws" {
  region = "us-east-1"
}

# -------------------------------
# Create MySQL RDS Instance
# -------------------------------
resource "aws_db_instance" "mysql_rds" {
  identifier              = "my-mysql-db"
  engine                  = "mysql"
  engine_version          = "8.0"                  # Optional, specify version
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "samir123"
  db_name                 = "dev"
  allocated_storage       = 20
  skip_final_snapshot     = true
  publicly_accessible     = true

  # Optional: Allow some time for DB initialization
  apply_immediately       = true
}

# -------------------------------
# Execute SQL Script Locally After RDS is Ready
# -------------------------------
resource "null_resource" "local_sql_exec" {
  depends_on = [aws_db_instance.mysql_rds]

  # Wait for the DB to be fully available
  provisioner "local-exec" {
    # NOTE: Use double quotes for interpolation
    command = <<EOT
      echo "Waiting for RDS to be ready...";
      sleep 60;
      echo "Running init.sql...";
      mysql -h ${aws_db_instance.mysql_rds.address} -u admin -psamir123 dev < init.sql
    EOT

    interpreter = ["bash", "-c"]
  }

  # Ensure it runs every time you apply (optional)
  triggers = {
    always_run = timestamp()
  }
}
