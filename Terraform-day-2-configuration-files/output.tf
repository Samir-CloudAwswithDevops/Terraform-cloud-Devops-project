output "public_ip" {
    value = aws_instance.name.public_ip
}

output "private_ip" {
    value = aws_instance.name.private_ip
}

output "availability_zone" {
    value = aws_subnet.public_subnet_1.availability_zone
}