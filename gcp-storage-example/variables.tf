variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "location" {
  description = "The location for storage buckets"
  type        = string
  default     = "US"
}

variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "example"
}

variable "bucket_names" {
  description = "Names of the buckets to create (without prefix)"
  type        = list(string)
  default     = ["data", "logs", "backups"]
}

variable "enable_versioning" {
  description = "Map of bucket name to enable versioning"
  type        = map(bool)
  default     = {}
}

variable "lifecycle_age_days" {
  description = "Age in days for lifecycle management"
  type        = number
  default     = 90
}

variable "labels" {
  description = "A map of labels to apply to resources"
  type        = map(string)
  default     = {
    environment = "test"
    project     = "terraform-examples"
    terraform   = "true"
  }
}
