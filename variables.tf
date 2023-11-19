variable "ami" {
  type = map(any)
  default = {
    us-east-1 = "ami-xxxxxxxxxxxxxxxx"
    us-west-1 = "ami-yyyyyyyyyyyyyyyy"
    us-west-2 = "ami-zzzzzzzzzzzzzzzz"
    # Add more regions as needed
  }
}

variable "instance_types" {
  type    = list(any)
  default = ["t2.micro", "t3.micro", "t3.small"] # Adjust instance types as needed
}
variable "key_name" {
  type    = string
  # You can set a default value if needed
  default = "cloud_2021"
}
