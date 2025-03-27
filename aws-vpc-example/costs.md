# AWS VPC Example - Cost Estimation

## Estimated Monthly Costs

Based on the default configuration, here's an estimate of the monthly costs:

| Resource                | Quantity | Cost per unit | Monthly Cost |
|------------------------|----------|---------------|---------------|
| VPC                    | 1        | $0.00         | $0.00         |
| NAT Gateway            | 1        | $32.85        | $32.85        |
| NAT Gateway Data Processing | Varies | $0.045/GB    | ~$20.00*      |
| EC2 t3.micro (if enabled) | 1      | $8.47         | $8.47         |
| EC2 EBS Storage 8GB    | 1        | $0.80         | $0.80         |
| **TOTAL (approximate)** |          |               | **$54.12-$62.12** |

*Data processing costs depend on actual usage

## Cost Saving Recommendations

1. **NAT Gateway**: The most expensive component is the NAT Gateway. If you don't require constant outbound internet access from your private subnets, consider using:
   - NAT Instances (cheaper but requires management)
   - VPC Endpoints for AWS services instead of internet access

2. **Single NAT Gateway**: The default configuration uses a single NAT Gateway. For production, you might want one per AZ for high availability, but this would multiply NAT costs.

3. **EC2 Instance**: The test instance is disabled by default. If enabled, consider:
   - Using Spot Instances for non-critical workloads (up to 90% cheaper)
   - Scheduling automatic shutdown during non-business hours
   - Rightsizing the instance type based on actual usage

## Infracost Configuration

Create a file named `infracost-config.yml` in this directory with the following content:

```yaml
version: 0.1
projects:
  - path: .
    usage_file: infracost-usage.yml
```

Create a file named `infracost-usage.yml` with the following content to estimate data transfer costs:

```yaml
version: 0.1
resource_usage:
  module.vpc.aws_nat_gateway.this[0]:
    monthly_data_processed_gb: 400
```

Run Infracost to get a detailed breakdown:

```bash
infracost breakdown --path . --config-file infracost-config.yml
```

## Additional Resources

- [AWS Pricing Calculator](https://calculator.aws/)
- [NAT Gateway Pricing](https://aws.amazon.com/vpc/pricing/)
- [EC2 Pricing](https://aws.amazon.com/ec2/pricing/)
