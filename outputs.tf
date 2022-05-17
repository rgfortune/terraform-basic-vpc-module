#------------------------------------------- 
# Outputs 
#------------------------------------------- 

output "vpc_id" { value = aws_vpc.vpc.id }
output "cidr_block" { value = aws_vpc.vpc.cidr_block }

output "availability_zones_count" { value = var.availability_zones_count }

output "public_subnets" { value = aws_subnet.public_subnets }

output "private_subnets_00" { value = aws_subnet.private_subnets_00 }
output "private_subnets_01" { value = aws_subnet.private_subnets_01 }
output "private_subnets_02" { value = aws_subnet.private_subnets_02 }
