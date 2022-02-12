#------------------------------------------- 
# Outputs 
#------------------------------------------- 

output "vpc_id" { value = aws_vpc.vpc.id }
output "vpc_cidr_block" { value = aws_vpc.vpc.cidr_block }

output "env" { value = var.env }

output "aws_publicSubnet00_id" { value = aws_subnet.publicSubnet00.id }
output "aws_publicSubnet01_id" { value = aws_subnet.publicSubnet01.id }

output "aws_privateSubnet00_id" { value = aws_subnet.privateSubnet00.id }
output "aws_privateSubnet01_id" { value = aws_subnet.privateSubnet01.id }
