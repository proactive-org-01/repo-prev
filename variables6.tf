variable "instance_type" {
  description = "The type of the instance"
  type        = string
  default     = "c4.xlarge"
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
  default     = "stackopsdemo1"
}