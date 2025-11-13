resource "aws_instance" "myec2" {
  ami = var.ami
  instance_type = var.instance_type
  key_name =aws_key_pair.mynewKP.key_name
  security_groups = [aws_security_group.mysg.id]
  associate_public_ip_address = true
  subnet_id = aws_subnet.sub1.id
  availability_zone = "us-east-1b"
  tags={
    Name ="kausalya"
  }
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags={
        Name="myvpc"
    }
  
}
resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
}
resource "aws_internet_gateway" "myig" {
  vpc_id = aws_vpc.myvpc.id
}
resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myig.id
  }
}

resource "aws_route_table_association" "routeassociation" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.myroute.id
}
resource "aws_security_group" "mysg" {
  name= "mysg"
  vpc_id = aws_vpc.myvpc.id
  ingress{
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    to_port = 0
    from_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "tls_private_key" "myec2-pvtkey" {
  algorithm = "RSA"
}
resource "aws_key_pair" "mynewKP" {
  key_name = "terraform-key"
  public_key = tls_private_key.myec2-pvtkey.public_key_openssh
}
resource "local_file" "private-key" {
  content = tls_private_key.myec2-pvtkey.private_key_openssh
  filename = "${path.module}/terraform-key.pem"
  file_permission = "0600"
}