variable "aws-region" {
  description = "enter the keypair name in the region you chose" 
  type        = string
  default = "us-west-1"
}
variable "key-pair" {
  description = "enter the keypair name in the region you chose" 
  type        = string
}
variable "local-ipv4" {
  description = "enter the local public ipv4 of your pc (windows cmd command: 'curl -s http://ipv4.icanhazip.com', bash: 'echo $(curl -s http://ipv4.icanhazip.com)'" 
  type        = string
}
variable "full-path-of-key-pair" {
  description = "enter the full path of the keypair file from your pc" 
  type        = string
}
variable "aws-ami-of-region" {
  description = "enter the image of the instance in the region you chose" 
  type        = string
  default = "ami-03ed1381c73a5660e"
}

