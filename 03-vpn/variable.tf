variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    project = "roboshop"
    envinorment = "dev"
    terraform = "true"
  }
}
