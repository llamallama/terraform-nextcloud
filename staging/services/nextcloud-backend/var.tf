variable "environment" {
  default = "staging"
}
variable "lb_name" {
  default = "NextcloudStaging"
}
variable "use_tls" {
  default = 1
}
variable "certificate_arn" {
  default = "arn:aws:acm:us-east-1:887110813782:certificate/8906e621-ee45-40b6-9ba7-7e31017d80ce"
}
