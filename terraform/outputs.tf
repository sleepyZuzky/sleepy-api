output "vpc_id" {
  value = aws_vpc.sleepy_network.id
}

output "public_subnets" {
  value = length(aws_subnet.public_subnets) > 0 ? {for net in aws_subnet.public_subnets: net.availability_zone => net.id} : null
}
