#------------------------------------------- 
# Outputs 
#------------------------------------------- 

output "vpc_id" { value = aws_vpc.vpc.id }
output "cidr_block" { value = aws_vpc.vpc.cidr_block }

output "availability_zones" { value = local.availability_zones }

output "eks_eni_subnets" { value = aws_subnet.eks_eni_subnets }

output "public_subnets" { value = aws_subnet.public_subnets }

output "private_subnets_00" { value = aws_subnet.private_subnets_00 }
output "private_subnets_01" { value = aws_subnet.private_subnets_01 }
output "private_subnets_02" { value = aws_subnet.private_subnets_02 }

output "private_route_tables" { value = aws_route_table.private_route_tables}
output "public_route_table" { value = aws_route_table.public_route_table}