# GCP Storage Example - Cost Estimation

## Estimated Monthly Costs

Based on the default configuration, here's an estimate of the monthly costs:

| Resource                | Quantity | Cost per unit | Monthly Cost |
|------------------------|----------|---------------|---------------|
| Standard Storage (first 5TB) | 50 GB*   | $0.020/GB     | $1.00         |
| Cloud Function Invocations | 2M*    | $0.0000004/invocation | $0.80        |
| Cloud Function Compute (128MB) | 1M sec* | $0.0000025/100ms | $0.25        |
| Storage Operations (Class A) | 100k*  | $0.05/10k     | $0.50         |
| Storage Operations (Class B) | 400k*  | $0.004/10k    | $0.16         |
| Cloud Function Egress | 5 GB*     | $0.12/GB      | $0.60         |
| **TOTAL (approximate)** |          |               | **$3.31**     |

*These values are estimates and will vary based on actual usage

## Cost Saving Recommendations

1. **Storage Class Selection**: The default storage class is Standard. Consider:
   - Nearline storage for data accessed less than once a month (cheaper but with retrieval fees)
   - Coldline or Archive storage for long-term archival (much cheaper but higher retrieval costs)

2. **Lifecycle Policies**: The configured lifecycle policy deletes objects older than 90 days. Consider:
   - Transitioning to cheaper storage classes instead of deleting
   - Implementing more granular lifecycle rules based on object prefixes

3. **Cloud Function Optimization**:
   - Minimize function execution time and memory allocation
   - Bundle related operations to reduce the number of invocations
   - Consider Cloud Run for more predictable workloads

4. **Regional vs. Multi-regional**: The default location is "US" (multi-regional). Using a specific region like "us-central1" can reduce storage costs by approximately 20%.

## Infracost Configuration

Create a file named `infracost-config.yml` in this directory with the following content:

```yaml
version: 0.1
projects:
  - path: .
    usage_file: infracost-usage.yml
```

Create a file named `infracost-usage.yml` with the following content:

```yaml
version: 0.1
resource_usage:
  module.cloud_storage.google_storage_bucket.buckets["example-data"]:
    storage_gb: 50
    monthly_class_a_operations: 100000
    monthly_class_b_operations: 400000
  module.cloud_function.google_cloudfunctions_function.function:
    monthly_invocations: 2000000
    monthly_compute_seconds: 1000000
    average_response_size_kb: 128
```

Run Infracost to get a detailed breakdown:

```bash
infracost breakdown --path . --config-file infracost-config.yml
```

## Additional Resources

- [Google Cloud Pricing Calculator](https://cloud.google.com/products/calculator)
- [Cloud Storage Pricing](https://cloud.google.com/storage/pricing)
- [Cloud Functions Pricing](https://cloud.google.com/functions/pricing)
