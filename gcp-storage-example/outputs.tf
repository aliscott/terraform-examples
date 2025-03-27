output "bucket_names" {
  description = "List of bucket names"
  value       = module.cloud_storage.names
}

output "bucket_urls" {
  description = "List of bucket URLs"
  value       = module.cloud_storage.urls
}

output "function_bucket_name" {
  description = "Name of the bucket storing function code"
  value       = google_storage_bucket.function_bucket.name
}

output "function_name" {
  description = "Name of the deployed function"
  value       = module.cloud_function.name
}

output "function_url" {
  description = "URL of the deployed function"
  value       = module.cloud_function.https_trigger_url
}
