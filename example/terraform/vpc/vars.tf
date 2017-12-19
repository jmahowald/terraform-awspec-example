variable "primary_cidr_block" {
  description = "The primary cidr of most of the subnets (tenants have a separate cidr base)"
  default     = "10.0.0.0/8"
}

variable "region_newbits" {
  description = "the amount of bits added to the base for each new region"
  default     = 8
}

variable "standard_subnet_newbits" {
  description = "the amount of bits to add for a logical subnet (will actually have two, one in a and b az)"
  default     = 9
}

variable "region_subnet_names" {
  default = ["infra", "noc", "dmz", "core"]
}
