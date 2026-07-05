# Azure Terraform Modules

This directory contains reusable Terraform modules for provisioning Azure infrastructure resources. The modules are organized into **Child Modules** (reusable components) and a **Parents Module** (orchestrator that combines child modules).

## Directory Structure

```
Module/
├── Child Module/
│   ├── azure_resource_group/     # Creates Azure Resource Groups
│   ├── azure_virtual_network/    # Creates Azure Virtual Networks
│   └── azure_subnets/             # Creates Azure Subnets
└── Parents_Module/                # Main configuration that orchestrates child modules
```

## Child Modules

### 1. azure_resource_group
Creates one or more Azure Resource Groups.

**Source:** `./Child Module/azure_resource_group`

**Input Variables:**
- `resource_groups` (map): A map of resource group configurations
  - `name` (string): Name of the resource group
  - `location` (string): Azure region location

**Example:**
```hcl
module "resource_group" {
  source = "../Child Module/azure_resource_group"
  resource_groups = {
    rg1 = {
      name     = "my-resource-group"
      location = "East US"
    }
  }
}
```

---

### 2. azure_virtual_network
Creates one or more Azure Virtual Networks.

**Source:** `./Child Module/azure_virtual_network`

**Input Variables:**
- `virtual_networks` (map): A map of virtual network configurations
  - `name` (string): Name of the virtual network
  - `address_space` (list): CIDR blocks for the virtual network (e.g., `["10.0.0.0/16"]`)
  - `location` (string): Azure region location
  - `resource_group_name` (string): Name of the resource group to deploy in

**Example:**
```hcl
module "virtual_network" {
  source = "../Child Module/azure_virtual_network"
  virtual_networks = {
    vnet1 = {
      name                = "my-vnet"
      address_space       = ["10.0.0.0/16"]
      location            = "East US"
      resource_group_name = "my-resource-group"
    }
  }
}
```

---

### 3. azure_subnets
Creates one or more Azure Subnets within virtual networks.

**Source:** `./Child Module/azure_subnets`

**Input Variables:**
- `subnets` (map): A map of subnet configurations
  - `name` (string): Name of the subnet
  - `resource_group_name` (string): Name of the resource group
  - `virtual_network_name` (string): Name of the virtual network
  - `address_prefixes` (list): CIDR blocks for the subnet (e.g., `["10.0.1.0/24"]`)

**Example:**
```hcl
module "subnet" {
  source = "../Child Module/azure_subnets"
  subnets = {
    subnet1 = {
      name                 = "my-subnet"
      resource_group_name  = "my-resource-group"
      virtual_network_name = "my-vnet"
      address_prefixes     = ["10.0.1.0/24"]
    }
  }
}
```

---

## Parents Module

The **Parents_Module** is the main orchestrator that demonstrates how to use all child modules together in a complete configuration.

**Location:** `./Parents_Module`

**Files:**
- `main.tf` - Contains module definitions and dependencies
- `provider.tf` - Terraform and provider configuration

### Configuration Highlights

The Parents_Module sets up:
- **Resource Group:** `rg-practice-module-3` in East US
- **Virtual Network:** `vnet-practice-module-3` with address space `10.4.0.0/16`
- **Subnets:** Two subnets
  - `subnet-practice-module-3` with address prefix `10.4.1.0/24`
  - `subnet-practice-module-4` with address prefix `10.4.2.0/24`

### Module Dependencies

The modules are configured with `depends_on` to ensure proper creation order:
1. Resource Group is created first
2. Virtual Network depends on Resource Group
3. Subnets depend on Virtual Network

**Provider Configuration:**
- **Provider:** `azurerm` version `4.80.0`
- **Features:** Empty features block for compatibility

---

## Usage

### Using Child Modules Independently

You can use any child module independently in your own Terraform configuration:

```hcl
module "my_rg" {
  source = "./Azure/Terraform/Module/Child Module/azure_resource_group"
  resource_groups = {
    prod = {
      name     = "prod-rg"
      location = "West Europe"
    }
  }
}
```

### Using the Complete Stack

To use the complete setup with all modules:

```bash
cd Azure/Terraform/Module/Parents_Module
terraform init
terraform plan
terraform apply
```

---

## Requirements

- **Terraform** >= 1.0
- **Azure Provider** >= 4.80.0
- **Azure Subscription** with appropriate credentials configured

---

## Module Features

✅ **Reusable Components** - Each child module is independent and can be used separately
✅ **for_each Loop** - Supports creating multiple resources of each type
✅ **Dependency Management** - Proper `depends_on` declarations ensure correct resource order
✅ **Variable Maps** - Uses maps for flexible multi-resource provisioning

---

## Notes

- The current configuration includes typo: `mian.tf` in azure_virtual_network (should be `main.tf`)
- All modules use `for_each` for dynamic resource creation
- Ensure Azure credentials are configured before running `terraform apply`
- Update location and naming conventions as needed for your environment

---

## Contributing

When adding new child modules:
1. Create a new directory under `Child Module/`
2. Include a `main.tf` with variable declarations and resource definitions
3. Document variable inputs in this README
4. Update the Parents_Module if needed
