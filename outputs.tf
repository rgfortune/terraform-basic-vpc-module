#------------------------------------------- 
# Outputs 
#------------------------------------------- 

output "vpc_id" { value = aws_vpc.vpc.id }
output "vpc_cidr_block" { value = aws_vpc.vpc.cidr_block }

output "aws_availabilityZonesCount" { value = var.availability_zones_count }

output "aws_publicSubnets" { value = aws_subnet.publicSubnets }
output "aws_privateSubnets" { value = aws_subnet.privateSubnets }
