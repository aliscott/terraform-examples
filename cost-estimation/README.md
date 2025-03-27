# Cost Estimation for Terraform Projects

This directory contains cost estimation configurations and tools to help understand the potential costs of running the infrastructure defined in this repository.

## Methods for Cost Estimation

1. **Infracost Integration**: Configuration files for [Infracost](https://www.infracost.io/), which provides cloud cost estimates for Terraform

2. **Terraform Plan Analysis**: Scripts to analyze `terraform plan` output and estimate costs

3. **Cloud Provider Pricing Calculators**: Links and configurations for cloud provider specific pricing calculators

## Usage

Each project directory contains a `costs.md` file with estimated costs for the default configuration and instructions for using these cost estimation tools.

### Using Infracost

1. Install Infracost: https://www.infracost.io/docs/
2. Navigate to the project directory
3. Run: `infracost breakdown --path .`

### Cloud Provider Pricing Calculators

- AWS Pricing Calculator: https://calculator.aws/
- Azure Pricing Calculator: https://azure.microsoft.com/en-us/pricing/calculator/
- Google Cloud Pricing Calculator: https://cloud.google.com/products/calculator
