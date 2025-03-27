# Azure AKS Example - Cost Estimation

## Estimated Monthly Costs

Based on the default configuration, here's an estimate of the monthly costs:

| Resource                | Quantity | Cost per unit | Monthly Cost |
|------------------------|----------|---------------|---------------|
| Virtual Network        | 1        | $0.00         | $0.00         |
| AKS Cluster Management | 1        | $0.00*        | $0.00         |
| Standard_D2s_v3 Nodes  | 1-3**    | $67.16        | $67.16-$201.48 |
| Load Balancer (Standard) | 1      | $22.63        | $22.63        |
| Load Balancer Data Processing | Varies | $0.005/GB  | ~$5.00***     |
| Storage (OS Disks)     | 1-3**    | $5.89         | $5.89-$17.67   |
| **TOTAL (approximate)** |          |               | **$100.68-$246.78** |

*AKS does not charge for the cluster management, only for the underlying compute resources
**Autoscaling is configured to use 1-3 nodes based on load
***Data processing costs depend on actual usage

## Cost Saving Recommendations

1. **Node VM Size**: The default `Standard_D2s_v3` VM size might be oversized for testing. Consider:
   - Using smaller VM sizes like `Standard_B2s` for non-production workloads
   - Using spot instances via `spot_max_price` parameter for non-critical workloads

2. **Autoscaling Configuration**: Adjust the min/max node count for your actual needs:
   - Reduce `agents_max_count` if you don't need to scale to 3 nodes
   - Consider a minimum of 0 nodes for dev environments with cluster autoscaler

3. **Load Balancer**: The Standard Load Balancer is required but contributes significant fixed cost:
   - Consolidate services to minimize the number of load balancers
   - Use Kubernetes ingress controllers to share a single load balancer among multiple services

4. **Region Selection**: Azure pricing varies by region. Consider using a less expensive region for non-production workloads.

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
  module.aks.azurerm_kubernetes_cluster.main:
    monthly_outbound_data_gb: 1000
```

Run Infracost to get a detailed breakdown:

```bash
infracost breakdown --path . --config-file infracost-config.yml
```

## Additional Resources

- [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/)
- [AKS Pricing](https://azure.microsoft.com/en-us/pricing/details/kubernetes-service/)
- [Azure VM Pricing](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/)
