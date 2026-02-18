variable "region" {
  type    = string
  default = "ap-south-1"
}


variable "image_tag" {
  type    = string
  default = "latest"
}

# variable "db_name" {
#   type    = string
#   default = "strapi_db"
# }
variable "db_name" {
  type    = string
  default = "strapi-db"  # only lowercase letters and hyphens
}


variable "db_username" {
  type    = string
  default = "strapiadmin"
}
