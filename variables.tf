variable "aws-region" {
    description = "this variable having aws region"
    type = string
    default = "ap-south-1"
  }

variable "vpc-dev" {
    description = "this variable having vpc cidr value"
    type = string
    default = "10.0.0.0/16"
  }

variable "vpc-tag-name" {
    description = "this variable having vpc tagname"
    type = string
    default = "vpc-dev"
  }

variable "subnet-dev" {
    description = "this variable having subnet cidr value"
    type = string
    default = "10.0.1.0/24"
  }

variable "subnet-tag-name" {
    description = "this variable having subnet tagname"
    type = string
    default = "subnet-dev"
  }

variable "subnet-region" {
    description = "this variable having subnet region"
    type = string
    default = "ap-south-1a"
  }

variable "igw-tag-name" {
    description = "this variable having igw tagname"
    type = string
    default = "igw-dev"
  }

variable "rt-tag-name" {
    description = "this variable having rt tagname"
    type = string
    default = "rt-dev"
  }

variable "route" {
    description = "this variable having route destination cidr value"
    type = string
    default = "0.0.0.0/0"
  }

variable "sg" {
    description = "this variable having sg tagname"
    type = string
    default = "web-sg"
  }

variable "ami" {
    description = "this variable having ami value"
    type = string
    default = "ami-0c42696027a8ede58"
  }

variable "instanceType" {
    description = "this variable having the instance type"
    type = string
    default = "t2.micro"
  }

variable "instanceName" {
    description = "this variable having instance tagname"
    type = string
    default = "web"
  }

variable "eip"{
    description = "this variable having elastic ip"
    type = string
    default = "web-eip"
  }

variable "dockerhub_credentials" {
  type = string
}

variable "codestar_connector_credentials" {
  type = string
}
