
variable "key_name" {
  type = string
  default = "lav-key"
}
variable "environment" {
  type = string
  default = "prod"
  description = "Environment tag"
}

variable "dockerhub_repo" {
  type        = string
  description = "Docker Hub repo (e.g., username/strapi-app)"
  default = "vamshikrishnanaliganti/strapi-app"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag"
}

variable "region" {
  type = string
}

variable "db_name" {
  type    = string
  default = "strapi"
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "ecr_repo_url" {
  type        = string
  description = "ECR repository URL for Strapi image"
}

# variable "image_tag" {
#   description = "Git commit SHA used as Docker image tag"
#   type        = string
# }

# variable "ecs_execution_role_arn" {
#   description = "Existing ECS Task Execution Role ARN provided by company"
#   type        = string
# }

# variable "db_username" {
#   type = string
# }

# variable "db_password" {
#   type      = string
#   sensitive = true
# }

# variable "ecr_repo_name" {
#   description = "ECR repository name to create"
#   type        = string
#   default     = "lav-strapi-app"
# }