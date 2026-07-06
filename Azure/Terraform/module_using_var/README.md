# Terraform module: module_using_var

Short description
A short one-line description of what this module creates (for example: "Creates an Azure resource group and example resources using module variables").

## Requirements
- Terraform >= 1.0
- Azure CLI or a Service Principal with appropriate permissions (Contributor or as required)
- Provider:
  - azurerm >= 3.0

## Usage

Basic example (call this module from a root configuration):

```hcl
module "example" {
  source = "./Azure/Terraform/module_using_var"

  # Replace these with actual variables from this module
  resource_group_name = "rg-example"
  location            = "eastus"
  example_var         = "value"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| resource_group_name | Name for the resource group | string | n/a | yes |
| location | Azure region (e.g., eastus) | string | "eastus" | no |
| example_var | Example variable — replace with real ones | string | "" | no |

Note: Replace the above inputs with the exact variables present in this module's variables.tf (names, types, defaults, and descriptions).

## Outputs

| Name | Description |
|------|-------------|
| resource_group_id | The ID of the created resource group |
| example_output | Example output — replace with real outputs |

Replace the example outputs above with the actual outputs found in this module's outputs.tf.

## Example (local test)

Create a `test` folder with a `main.tf`:

```hcl
provider "azurerm" {
  features {}
}

module "example" {
  source = "../Azure/Terraform/module_using_var"
  resource_group_name = "rg-test"
  location            = "eastus"
  example_var         = "hello"
}
```

Then run:
- terraform init
- terraform plan
- terraform apply

## Auto-generate inputs/outputs (optional)
If you prefer to generate README tables automatically, install terraform-docs and run it from the module folder:

```bash
# from repo root (or from the module folder)
cd Azure/Terraform/module_using_var
terraform-docs markdown table . > README.md
```

This will populate Inputs and Outputs tables based on variable and output blocks (requires terraform-docs installed).

## Contributing
Contributions welcome. Please include tests/examples for changes and update the README accordingly.

## License
Specify your license (e.g., MIT) or link to the repository license.
