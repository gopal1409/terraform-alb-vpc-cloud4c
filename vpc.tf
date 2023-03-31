##3it will create a vpc with cidr block i have given
resource "aws_vpc" "this" {
  cidr_block           = "10.20.20.0/26"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Application-1-Gopal"
  }
}

###once we creat the vpc next we will create subnet
##3we need to create the subnet and attach with vpc
resource "aws_subnet" "private" {
  ####we are using length functionality to find our how many subnet i have
  count = length(var.subnet_cidr_private)
  #####once subnet get create it need to attached with vpc
  vpc_id = aws_vpc.this.id
  ###last two block ensuring that wehn we create a subnet it should go into one az
  cidr_block        = var.subnet_cidr_private[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    Name = "Application-1"
  }
}
##3we createing a rtb custom rtb
resource "aws_route_table" "this-rt" {
  ###attach the rtb with vpc
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "Application-1-rtb"
  }
}
##3once you create  csutom rtb we need to manually do subnet assocation. 
resource "aws_route_table_association" "private" {
  ###using length functinalityl i found out what are the subnet i have
  count = length(var.subnet_cidr_private)
  ##3in terraform if you want to do iteration one by one element
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.this-rt.id

}

resource "aws_internet_gateway" "this-igw" {
  vpc_id = aws_vpc.this.id

}

resource "aws_route" "internet_route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.this-rt.id
  gateway_id             = aws_internet_gateway.this-igw.id
}