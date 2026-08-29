variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
  default     = "ami-0f58b397bc5c1f2e8"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "web_count" {
  description = "Number of web servers"
  type        = number
  default     = 2
}

variable "public_subnet_id" {
  description = "Public subnet for web servers"
  type        = string
}

variable "web_security_group_id" {
  description = "Security group for web servers"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet for the database"
  type        = string
}

variable "db_security_group_id" {
  description = "Security group for the database"
  type        = string
}