# Terraform Examples

This repository contains three example Terraform projects using popular open source modules:

## 1. AWS VPC Example

A simple AWS infrastructure setup with:
- VPC using the popular `terraform-aws-modules/vpc` module
- Public and private subnets across multiple availability zones
- NAT Gateways for private subnet internet access
- Optional test EC2 instance with security group

**Key modules used:**
- [terraform-aws-modules/vpc](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)

## 2. Azure AKS Example

An Azure Kubernetes Service deployment with:
- Resource Group
- Virtual Network with subnets using `Azure/network/azurerm` module
- AKS Cluster with autoscaling node pool using `Azure/aks/azurerm` module

**Key modules used:**
- [Azure/network/azurerm](https://registry.terraform.io/modules/Azure/network/azurerm/latest)
- [Azure/aks/azurerm](https://registry.terraform.io/modules/Azure/aks/azurerm/latest)

## 3. GCP Storage Example

A Google Cloud Platform storage setup with:
- Multiple storage buckets with lifecycle policies using `terraform-google-modules/cloud-storage/google`
- Example Cloud Function triggered by storage events using `terraform-google-modules/cloudfunctions/google`

**Key modules used:**
- [terraform-google-modules/cloud-storage/google](https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/latest)
- [terraform-google-modules/cloudfunctions/google](https://registry.terraform.io/modules/terraform-google-modules/cloudfunctions/google/latest)

## Prerequisites

- Terraform >= 1.0.0
- Appropriate cloud provider accounts and credentials:
  - AWS credentials for the AWS example
  - Azure credentials for the Azure example
  - GCP credentials for the GCP example

## Usage

Each directory contains a standalone Terraform project. To use any example:

1. Navigate to the desired example directory:
   ```bash
   cd aws-vpc-example
   # or
   cd azure-aks-example
   # or
   cd gcp-storage-example
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the planned changes:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

5. When you're done, clean up resources:
   ```bash
   terraform destroy
   ```

## Configuration

Each example includes default values in its `variables.tf` file. You can override these defaults by:

1. Editing the variables directly in the `variables.tf` file
2. Creating a `terraform.tfvars` file with your custom values
3. Setting environment variables prefixed with `TF_VAR_`
4. Passing variable values on the command line with the `-var` flag

## Important Notes

- These examples create real resources in your cloud accounts which may incur costs
- Always run `terraform destroy` when you're done testing
- Some resources like NAT Gateways in AWS or AKS clusters in Azure can be expensive if left running
- The GCP example requires a project ID to be specified

## Directory Structure

```
terraform-examples/
├── aws-vpc-example/         # AWS VPC with public and private subnets
├── azure-aks-example/       # Azure Kubernetes Service deployment
└── gcp-storage-example/     # GCP storage buckets and Cloud Function
```

## Contributing

Feel free to submit pull requests to enhance these examples or add new ones.

## License

This project is licensed under the MIT License - see the LICENSE file for details.