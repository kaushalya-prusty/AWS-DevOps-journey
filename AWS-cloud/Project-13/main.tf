resource "aws_vpc" "KP" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "KP"
  }
  enable_dns_hostnames = true
  enable_dns_support = true
}
resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.KP.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  depends_on = [ aws_vpc.KP ]
}
resource "aws_subnet" "sub2" {
vpc_id = aws_vpc.KP.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  depends_on = [ aws_vpc.KP ]
}
resource "aws_db_subnet_group" "KP-my-SQLDB" {
name = "mysqldbgroup"
subnet_ids = [aws_subnet.sub1.id,aws_subnet.sub2.id]
depends_on = [aws_subnet.sub1, aws_subnet.sub2]
}
resource "aws_security_group" "KP-DB-sg" {
name = "KPDBSG"
vpc_id = aws_vpc.KP.id
ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
}
resource "aws_db_instance" "KPDB1" {
engine = "MYSQL"
engine_version = "8.0.40"
username = "admin"
password = "pwd12345555"
instance_class = "db.t3.micro"
allocated_storage = 20
publicly_accessible = true
db_subnet_group_name = aws_db_subnet_group.KP-my-SQLDB.id
vpc_security_group_ids = [aws_security_group.KP-DB-sg.id]
}
resource "aws_internet_gateway" "KPIGDB" {
vpc_id = aws_vpc.KP.id
  
}
resource "aws_route_table" "mydbroute" {
vpc_id = aws_vpc.KP.id
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.KPIGDB.id
}
}
resource "aws_route_table_association" "myassocdb1" {
subnet_id = aws_subnet.sub1.id
route_table_id = aws_route_table.mydbroute.id
}
resource "aws_route_table_association" "myassocdb2" {
subnet_id = aws_subnet.sub2.id
route_table_id = aws_route_table.mydbroute.id
}