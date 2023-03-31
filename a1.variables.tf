variable "region" {
  type    = string
  default = "us-east-1"
}

variable "access_key" {
  type      = string
  sensitive = true
  default   = ""
}

variable "secret_key" {
  type      = string
  sensitive = true
  default   = ""
}


variable "subnet_cidr_private" {
  default = ["10.20.20.0/28", "10.20.20.16/28", "10.20.20.32/28"]
  type    = list(any)
}

variable "availability_zone" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}