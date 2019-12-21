resource "aws_db_instance" "clerkdb" {
  allocated_storage    = 20
  deletion_protection  = true
  storage_type         = "gp2"
  engine               = "postgresql"
  engine_version       = "10.10"
  instance_class       = "db.t3.micro"
  identifier           = "clerkdb"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
}