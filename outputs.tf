#------------------------------------------- 
# Outputs 
#------------------------------------------- 

output "vpc_id" { value = aws_vpc.vpc.id }
output "vpc_cidr_block" { value = aws_vpc.vpc.cidr_block }

output "env" { value = var.env }

output "aws_subnet_publicAzA_id" { value = aws_subnet.publicAzA.id }
output "aws_subnet_publicAzB_id" { value = aws_subnet.publicAzB.id }

output "aws_subnet_privateAzA_id" { value = aws_subnet.privateAzA.id }
output "aws_subnet_privateAzB_id" { value = aws_subnet.privateAzB.id }
