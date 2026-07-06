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

---

# Parent (root) → Child module: detailed explanation and examples

This module is intended to be used as a child module that a parent (root) Terraform configuration calls. The parent provides input variable values to the child and can read outputs exported by the child. The examples below use the variables and outputs described earlier in this README: inputs `resource_group_name`, `location`, `example_var` and outputs `resource_group_id`, `example_output`.

## Overview and terminology
- Root module (parent): The directory you run `terraform init/plan/apply` in. It configures providers and calls child modules.
- Child module: A folder that the parent references with `module "name" { source = "..." }`.
- Parent module: Any module or root configuration that invokes another module (so a child can itself be a parent for nested modules).

## Example — parent (root) configuration that calls this child module

```hcl
# test-root/main.tf
provider "azurerm" {
  features {}
}

module "example" {
  # Path to this child module relative to the root module
  source = "../Azure/Terraform/module_using_var"

  # Pass inputs defined by the child module
  resource_group_name = "rg-parent-example"
  location            = "eastus"
  example_var         = "value-from-parent"
}

# Read outputs exported by the child module
output "child_resource_group_id" {
  value       = module.example.resource_group_id
  description = "The resource group id created by the child module"
}

output "child_example_output" {
  value       = module.example.example_output
  description = "An example output from the child module"
}
```

## Child module variable declarations (example)

The child must declare the variables it expects in `variables.tf`. Below is an example that matches the README’s Inputs table — adjust types, defaults, and descriptions to your actual `variables.tf`.

```hcl
# Azure/Terraform/module_using_var/variables.tf
variable "resource_group_name" {
  description = "Name for the resource group"
  type        = string
}

variable "location" {
  description = "Azure region (for example: eastus)"
  type        = string
  default     = "eastus"
}

variable "example_var" {
  description = "Example variable — replace with real ones"
  type        = string
  default     = ""
}
```

## Child module outputs (example)

Define outputs in `outputs.tf` so the parent can read useful attributes (IDs, names, endpoints, etc).

```hcl
# Azure/Terraform/module_using_var/outputs.tf
output "resource_group_id" {
  description = "The ID of the created resource group"
  value       = azurerm_resource_group.rg.id
}

output "example_output" {
  description = "Example output — replace with real outputs"
  value       = "example-${var.example_var}"
}
```

## How inputs flow
- The parent sets the child’s variables inside the `module` block. Required variables (no default) must be supplied by the parent. Optional variables may be omitted if the child defines sensible defaults.
- Complex types: pass maps, lists, and objects directly. If the child expects an object, ensure the parent provides the exact structure or use Terraform's type conversion functions.

## How outputs flow back to the parent
- The child exposes outputs via `output` blocks. The parent reads them as `module.<MODULE_NAME>.<OUTPUT_NAME>`, e.g. `module.example.resource_group_id`.
- Use outputs to expose resource IDs, connection strings, hostnames, and any attributes the parent (or other modules) must consume.

## Provider configuration and caveats
- Providers are normally configured in the root module. Child modules inherit provider configurations from the root automatically — do not reconfigure the same provider inside the child.
- If you need multiple provider instances (different subscriptions, tenants, or regions), create aliased providers in the root and pass them to the child via the `providers` meta-argument. Example:

```hcl
# test-root/providers.tf
provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "other"
  subscription_id = var.other_subscription_id
  features {}
}

module "example" {
  source = "../Azure/Terraform/module_using_var"

  providers = {
    azurerm = azurerm.other
  }

  resource_group_name = "rg-parent-example"
  location            = "eastus"
}
```

- If you do not pass providers explicitly, the child uses the root's default provider instance.

## Nested modules and composition
- A child module can itself call other modules. In that case it acts as a parent for those nested modules. Inputs/outputs propagate up through the same patterns: pass inputs down, re-expose outputs up.
- Keep modules focused and composable. Prefer small, single-responsibility modules and compose them within parent modules.

## Using count / for_each with modules
- You can instantiate multiple module instances using `count` or `for_each`:

```hcl
module "example_multi" {
  source = "../Azure/Terraform/module_using_var"
  for_each = toset(["one","two"])
  resource_group_name = "rg-${each.value}"
  location            = "eastus"
  example_var         = each.value
}
# Access outputs:
# module.example_multi["one"].resource_group_id
```

## Testing locally vs referencing a published module
- Local testing: use a relative path in source (`source = "../Azure/Terraform/module_using_var"`). This is convenient for development.
- VCS source example:
  - Git URL with subdirectory: `source = "git::https://github.com/AnktsghV/Azure.git//Azure/Terraform/module_using_var?ref=main"`
  - Terraform Registry (when published): use registry source syntax and pinned versions.
- Always run `terraform init` in the parent directory after changing module source references.

## Validation, formatting, and lifecycle commands
- Commands you should run from the parent (root) directory:
  - terraform init
  - terraform validate
  - terraform plan
  - terraform apply
- Use terraform fmt in both parent and module directories to keep code formatting consistent.

## Best practices
- Document every variable and output in variables.tf and outputs.tf; keep README tables in sync with these files.
- Export the minimal set of outputs required by the parent — prefer IDs and resource names over whole resource objects.
- Avoid provider configuration inside modules; configure providers in the root and pass aliased providers when needed.
- Treat modules as public APIs: changes to variable names, types, or outputs are breaking changes for consumers — version accordingly.
- Add examples and a local test folder to show how to call the module.

## Common troubleshooting
- Missing output error: If you reference `module.<name>.<output>` that doesn't exist, Terraform will error during plan. Ensure outputs.tf defines that output.
- Provider errors: If a provider is not configured in the root, the plan will fail — add provider config to the root or pass a provider to the module using `providers = { ... }`.
- Relative source paths: If you move the parent directory, relative paths might break. For CI or reproducible builds, prefer VCS or registry sources.
- Sensitive data: mark sensitive outputs with `sensitive = true`. Parents reading sensitive outputs will still receive them but Terraform prevents accidental display in logs.

## Security and secrets
- Do not hard-code secrets in variables.tf defaults or outputs. Use secure means (environment variables, key vaults, or Terraform Cloud variable sets) to provide sensitive values.
- Mark outputs that contain secrets with `sensitive = true`.


---

If you want, I can also:
- Insert the exact contents of this module's variables.tf and outputs.tf into the README (if you give me permission to read those files),
- Create a test folder (test-root) in the repo with the example `main.tf` and a simple `terraform.tfvars` (non-sensitive) to demonstrate local testing, or
- Open a pull request with this README update.
