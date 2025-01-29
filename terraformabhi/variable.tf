variable "vpc_cidr" {
    type        = string
    description = "Enter the VPC CIDR Value"
    default = "192.168.0.0/16"
}

variable "vpc_tag_name" {
    type        = string
    description = "Enter VPC tag Name"
    default     = "terravpcab25"
}

variable "instance_type" {
    type        = string
    description = "Enter the EC2 instance type"
    default     = "t2.micro"
}

variable "public_cidr" {
    type = list(string)
    default = ["192.168.1.0/24", "192.168.2.0/24"]  # Updated public CIDR blocks
}

variable "private_cidr" {
    type = list(string)
    default = ["192.168.3.0/24", "192.168.4.0/24"]  # Updated private CIDR blocks
}

variable "instance_count" { 
    type = list(string)     
    default = [1,2,3,4]
}

variable "instance_key_name" {
    type = string
    default = "abhi1"
}

variable "vol_size" {
    type = number 
    default = 8
}

variable "bucket_name" {
    type = string 
    default = ""
}