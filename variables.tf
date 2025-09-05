variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "S3 bucket name (must be globally unique)"
  type        = string
  default     = "abm-static-website"
}

variable "index_file" {
  description = "Index document"
  type        = string
  default     = "index.html"
}

variable "error_file" {
  description = "Error document"
  type        = string
  default     = "error.html"
}
