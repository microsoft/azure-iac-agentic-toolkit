# GitHub Copilot Instructions for Azure Reverse Engineering Toolkit

## Purpose
This document guides GitHub Copilot on when and how to use `aztfexport` to reverse engineer manually created Azure resources into Terraform Infrastructure-as-Code templates.

## When to Use aztfexport

Use `aztfexport` when:
- The user wants to convert existing Azure resources to Terraform code
- Azure resources were created manually (via Azure Portal, CLI, or PowerShell) and need to be brought under Terraform management
- The user needs to document existing Azure infrastructure as code
- Migration from manual infrastructure management to Infrastructure-as-Code is required
- The user mentions terms like "reverse engineer", "import to Terraform", "export to Terraform", or "convert Azure resources"

Do NOT use `aztfexport` when:
- Creating new Azure infrastructure from scratch (use Terraform directly)
- The resources are already managed by Terraform
- The user only needs to read/query Azure resources without creating Terraform files

## aztfexport Modes

### 1. Resource Mode
Export a single Azure resource by Resource ID, with optional recursive dependencies.

```bash
aztfexport resource <resource-id>
```

**When to use:**
- Exporting a specific resource (e.g., one storage account, one VM)
- Testing the export process
- The user provides a specific Azure Resource ID
- Need to export a resource and its dependencies using `--recursive`

**Example:**
```bash
# Export a single resource
aztfexport resource /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myRG/providers/Microsoft.Storage/storageAccounts/mystorageacct

# Export a resource and its dependencies recursively
aztfexport resource --recursive /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myRG/providers/Microsoft.Compute/virtualMachines/myVM

# Export a resource, its dependencies, and the parent resource group
aztfexport resource --recursive --include-resource-group <resource-id>
```

### 2. Resource Group Mode
Export all resources within an Azure Resource Group.

```bash
aztfexport resource-group <resource-group-name>
```

**When to use:**
- The user wants to export an entire resource group
- Multiple related resources need to be exported together
- The user mentions a resource group name

**Example:**
```bash
aztfexport resource-group production-rg
```

### 3. Query Mode
Export resources based on an Azure Resource Graph query.

```bash
aztfexport query <query>
```

**When to use:**
- Exporting resources based on specific criteria (tags, types, locations)
- Need to filter resources across multiple resource groups
- Complex selection criteria required

**Example:**
```bash
aztfexport query "Resources | where type =~ 'Microsoft.Compute/virtualMachines' and tags['Environment'] == 'Production'"
```

### 4. Mapping File Mode
Export resources defined in a mapping file.

```bash
aztfexport mapping-file <mapping-file-path>
```

**When to use:**
- Pre-defined list of resources to export
- Repeatable export process
- The user has already created a mapping file

## Common aztfexport Options

### Output Directory
```bash
aztfexport <mode> <target> --output-dir <directory>
```
**Use when:** The user specifies where to save the Terraform files or when organizing exports into specific directories.

### Non-Interactive Mode
```bash
aztfexport <mode> <target> --non-interactive
```
**Use when:** Running in automation, CI/CD pipelines, or when user wants automatic execution without prompts.

### Append Mode
```bash
aztfexport <mode> <target> --append
```
**Use when:** Adding resources to existing Terraform configuration rather than creating new files.

### Continue on Error
```bash
aztfexport <mode> <target> --continue
```
**Use when:** Some resources might fail to export but you want to continue with others.

### Name Pattern
```bash
aztfexport <mode> <target> --name-pattern <pattern>
```
**Use when:** The user wants custom naming for Terraform resource names.

### Module Path
```bash
aztfexport <mode> <target> --module-path <path>
```
**Use when:** Exporting into a Terraform module structure.

### HCL Only Mode
```bash
aztfexport <mode> <target> --hcl-only
```
**Use when:** 
- User wants to generate only Terraform configuration files without importing to state
- Inspecting resources before committing to state management
- Exporting to review and modify before integration
- Equivalent to `terraform plan` - preview before applying

**Important:** Requires `--overwrite` flag if the target directory is not empty.

### Full Properties
```bash
aztfexport <mode> <target> --full-properties
```
**Use when:** 
- Need to see all configurable resource properties
- Learning about a newly released resource
- Investigating production issues
- Requires comprehensive resource documentation

**Warning:** May expose sensitive information (secrets, passwords) in generated config. Use with caution and protect the output.

### Overwrite
```bash
aztfexport <mode> <target> --overwrite
```
**Use when:** The output directory is not empty and needs to be overwritten (required with `--hcl-only` in non-empty directories).

### Recursive (Resource Mode Only)
```bash
aztfexport resource --recursive <resource-id>
```
**Use when:** Exporting a resource along with all its dependencies (e.g., VM with NICs, disks, NSGs).

### Include Resource Group (Resource Mode Only)
```bash
aztfexport resource --include-resource-group <resource-id>
```
**Use when:** Exporting a resource and also want to include its parent resource group (often used with `--recursive`).

### Provider Name
```bash
aztfexport <mode> <target> --provider-name=azapi
```
**Use when:** 
- User wants to export to AzAPI provider instead of default AzureRM provider
- Working with resources better supported by AzAPI
- Need newer resource types not yet in AzureRM

### Provider Version
```bash
aztfexport <mode> <target> --provider-version=<version>
```
**Use when:** Need to specify a particular version of the AzureRM or AzAPI provider.

### Generate Mapping File
```bash
aztfexport <mode> <target> --generate-mapping-file
```
**Use when:** 
- Discovering what resources exist in an environment
- Creating a reusable mapping for future exports
- Need to review resources before export

### Backend Configuration
```bash
aztfexport <mode> <target> --backend-type=<type> --backend-config=<key>=<value>
```
**Use when:** Exporting to a remote backend (Azure Storage, Terraform Cloud, etc.) inline without creating separate config files.

**Example:**
```bash
aztfexport resource-group my-rg \
  --backend-type=azurerm \
  --backend-config=resource_group_name=tfstate-rg \
  --backend-config=storage_account_name=tfstatestorage \
  --backend-config=container_name=tfstate \
  --backend-config=key=terraform.tfstate
```

### Include Role Assignments
```bash
aztfexport <mode> <target> --include-role-assignment
```
**Use when:** Need to export Azure RBAC role assignments along with resources.

### Environment
```bash
aztfexport <mode> <target> --env=<environment>
```
**Use when:** Working with non-public Azure clouds (e.g., `usgovernment`, `china`, `german`).

## Workflow Guidelines

### Pre-Export Checks
Before running `aztfexport`, ensure:
1. **Azure Authentication**: User is logged in via `az login`
2. **Subscription Context**: Correct subscription is selected with `az account set --subscription <id>`
3. **Permissions**: User has read access to the resources (and role assignments if using `--include-role-assignment`)
4. **Terraform Installed**: Terraform is available in the environment (version >= 0.12 required)
5. **Output Directory**: Target directory exists or can be created (or use `--overwrite` if not empty)

### Standard Export Process
1. **Identify the target** (resource ID, resource group, or query)
2. **Determine the appropriate mode**
3. **Choose options** based on user requirements
4. **Run aztfexport** with appropriate flags
5. **Review the generated files**:
   - `main.tf` (or `main.aztfexport.tf` if using `--append`) - Resource definitions
   - `terraform.tf` - Terraform settings and required providers
   - `provider.tf` - Provider configuration
   - `import.tf` - Import blocks (if not using `--hcl-only`)
   - `aztfexportResourceMapping.json` - Mapping file (if using `--generate-mapping-file`)
6. **Initialize Terraform**: Run `terraform init` in the output directory
7. **Validate**: Run `terraform plan` to ensure the state matches

### Post-Export Tasks
After successful export, recommend:
1. Review and organize the generated Terraform code
2. Run `terraform init` to initialize the configuration
3. Run `terraform plan` to verify no drift between actual and desired state
4. Consider splitting large configurations into modules
5. Add variables for parameterization
6. Implement remote state storage (e.g., Azure Storage Account)
7. Set up version control (git) for the Terraform files

## Common Commands Reference

### Basic Resource Group Export
```bash
# Export a resource group to current directory
aztfexport resource-group my-resource-group

# Export to specific directory in non-interactive mode
aztfexport resource-group my-resource-group --output-dir ./terraform/my-rg --non-interactive

# Export with role assignments included
aztfexport resource-group my-resource-group --include-role-assignment --non-interactive
```

### Export with Filters
```bash
# Export only VMs from a resource group
aztfexport query "Resources | where resourceGroup == 'my-rg' and type =~ 'Microsoft.Compute/virtualMachines'"

# Export resources with specific tag
aztfexport query "Resources | where tags['Environment'] == 'Production'"

# Export to AzAPI provider
aztfexport query --provider-name=azapi "Resources | where type =~ 'Microsoft.Storage/storageAccounts'"
```

### Export and Initialize
```bash
# Export and setup Terraform workspace
aztfexport resource-group my-rg --output-dir ./terraform/my-rg --non-interactive
cd ./terraform/my-rg
terraform init
terraform plan

# HCL-only export for review before state import
aztfexport resource-group my-rg --output-dir ./terraform/my-rg-review --hcl-only --overwrite --non-interactive

# Recursive resource export with dependencies
aztfexport resource --recursive --output-dir ./terraform/my-vm \
  /subscriptions/xxxx/resourceGroups/my-rg/providers/Microsoft.Compute/virtualMachines/myVM
```

## Error Handling

### Common Issues and Solutions

**Authentication Errors:**
```bash
# If aztfexport fails with auth errors
az login
az account show  # Verify correct subscription
```

**Resource Not Found:**
```bash
# Verify resource exists
az resource show --ids <resource-id>
```

**Permission Denied:**
```bash
# Check user's role assignments
az role assignment list --assignee <user-email> --all
```

**Terraform Provider Issues:**
- Ensure compatible Terraform version (>= 0.12 required)
- Check provider version constraints in generated `terraform.tf`
- Run `terraform init -upgrade` if needed
- If using `--provider-version`, ensure it matches your installed version

**Empty Directory Requirement:**
```bash
# If directory is not empty and you get an error
aztfexport resource-group my-rg --output-dir ./terraform/my-rg --overwrite --non-interactive
```

## Best Practices

1. **Start Small**: Begin with a single resource or small resource group to understand the output
2. **Use HCL-Only First**: Use `--hcl-only` flag to review configuration before importing to state (like `terraform plan` before `apply`)
3. **Use Non-Interactive Mode**: For automation and scripting
4. **Organize by Environment**: Export different environments (dev, staging, prod) into separate directories
5. **Version Control**: Commit generated Terraform files to git immediately after export
6. **Review Before Applying**: Always run `terraform plan` before `terraform apply`
7. **Document Custom Changes**: If you modify generated code, document why
8. **Use Modules**: Refactor large exports into reusable modules
9. **State Management**: Set up remote state storage for team collaboration using `--backend-type` and `--backend-config`
10. **Naming Conventions**: Use `--name-pattern` for consistent resource naming
11. **Incremental Adoption**: Don't try to export everything at once; start with critical resources
12. **Protect Sensitive Data**: Be cautious with `--full-properties` flag as it may expose secrets
13. **Use Mapping Files**: Generate mapping files with `--generate-mapping-file` for repeatable exports
14. **Leverage Recursive Exports**: Use `--recursive` in resource mode to automatically capture dependencies

## Integration with This Toolkit

This dev container environment provides:
- **aztfexport**: Pre-installed and ready to use
- **Terraform**: For initializing and validating exported configurations
- **Azure CLI**: For authentication and resource verification
- **Git**: For version control of generated IaC

When helping users:
1. Verify Azure authentication status
2. Suggest appropriate aztfexport mode based on their needs
3. Execute the export with suitable options
4. Guide through post-export validation
5. Recommend next steps for IaC adoption

## Example Workflows

### Workflow 1: Export Single Resource Group
```bash
# 1. Authenticate
az login
az account set --subscription "My Subscription"

# 2. Export resource group
aztfexport resource-group production-web-rg \
  --output-dir ./terraform/production-web \
  --non-interactive

# 3. Initialize and validate
cd ./terraform/production-web
terraform init
terraform plan
```

### Workflow 2: Export Specific Resource Types
```bash
# Export only storage accounts from a subscription
aztfexport query \
  "Resources | where type =~ 'Microsoft.Storage/storageAccounts'" \
  --output-dir ./terraform/storage-accounts \
  --non-interactive
```

### Workflow 3: Selective Export with Tags
```bash
# Export production resources with specific tags
aztfexport query \
  "Resources | where tags['Environment'] == 'Production' and tags['ManagedBy'] == 'Platform-Team'" \
  --output-dir ./terraform/platform-production \
  --non-interactive
```

### Workflow 4: HCL-Only Review Before State Import
```bash
# 1. First export HCL only to review
aztfexport resource-group my-rg \
  --output-dir ./temp-export \
  --hcl-only \
  --generate-mapping-file \
  --non-interactive

# 2. Review the generated configuration
cd ./temp-export
cat main.tf

# 3. If satisfied, use the mapping file to import to actual state
cd ../actual-terraform-dir
aztfexport mapping-file ../temp-export/aztfexportResourceMapping.json --append
```

### Workflow 5: Recursive Resource Export with Dependencies
```bash
# Export a VM with all its dependencies (NICs, disks, NSGs, etc.)
aztfexport resource \
  --recursive \
  --include-resource-group \
  --output-dir ./terraform/my-vm-complete \
  --non-interactive \
  /subscriptions/xxxx/resourceGroups/my-rg/providers/Microsoft.Compute/virtualMachines/myVM
```

### Workflow 6: Export to Remote Backend
```bash
# Export directly to Azure Storage backend
aztfexport resource-group production-rg \
  --backend-type=azurerm \
  --backend-config=resource_group_name=tfstate-rg \
  --backend-config=storage_account_name=tfstatestorage \
  --backend-config=container_name=tfstate \
  --backend-config=key=production.tfstate \
  --non-interactive
```

### Workflow 7: Export to AzAPI Provider
```bash
# Export resources using AzAPI provider instead of AzureRM
aztfexport resource-group my-rg \
  --provider-name=azapi \
  --provider-version=1.10.0 \
  --output-dir ./terraform/azapi-resources \
  --non-interactive
```

## Response Templates

### When User Asks to Export Resources

"I'll help you export your Azure resources to Terraform using aztfexport. First, let me verify:
1. You're authenticated to Azure
2. The correct subscription is selected
3. The target [resource/resource group/resources] exist

Then I'll run the appropriate aztfexport command and validate the generated Terraform configuration."

### After Successful Export

"Successfully exported resources to Terraform! Here's what was generated:
- `main.tf` (or `main.aztfexport.tf` if appended): Resource definitions
- `provider.tf`: Azure provider configuration
- `terraform.tf`: Terraform settings and provider requirements
- `import.tf`: Import blocks for state management (if not using --hcl-only)
- `aztfexportResourceMapping.json`: Resource mapping file (if --generate-mapping-file was used)

Next steps:
1. Review the generated configuration
2. Run `terraform init` to initialize
3. Run `terraform plan` to verify no drift
4. Consider organizing into modules if needed
5. If you used --hcl-only, you can now import to state using the mapping file
6. Be aware of potential limitations (write-only properties, cross-property constraints)

Would you like me to help with any of these steps?"

## Interactive Mode Features

When running aztfexport in interactive mode (default), users can:

**Navigation:**
- `↑` or `k`: Select previous item
- `↓` or `j`: Select next item  
- `←` or `h` or `Page Up`: Previous page
- `→` or `l` or `Page Down`: Next page
- `g` or `Home`: Jump to start
- `G` or `End`: Jump to end

**Operations:**
- `Delete`: Skip/unskip a resource
- `/`: Filter resources by text
- `Esc`: Clear filter
- `s`: Save mapping file
- `w`: Export resources (write)
- `r`: Show recommendations for current resource
- `e`: Show export errors
- `?`: Display help
- `q`: Quit

**Recommendation:** Suggest non-interactive mode (`--non-interactive`) for automation and scripts.

## Known Limitations

When helping users, be aware of these limitations:

1. **Write-Only Properties**: Cannot export passwords, secrets, and other write-only properties. Users must manually add these.

2. **Cross-Property Constraints**: Some properties conflict with each other; generated config might set both to the same value.

3. **Infrastructure Outside Scope**: Resources outside the export scope (e.g., role assignments) may be needed for complete functionality.

4. **Property-Defined Resources**: Some resources (like subnets) are exported as standalone resources but may be better as properties in parent resources.

5. **Explicit Dependencies Only**: Only explicit dependencies are captured; implicit dependencies must be refactored manually.

6. **Hardcoded Values**: Generated code uses hardcoded strings; recommend refactoring to variables.

7. **Not Production-Ready**: Generated configurations are not comprehensive and may require manual refinement for production use.

## Configuration Management

aztfexport stores configuration at `$HOME/.aztfexport/config.json`. Users can manage it via:

```bash
# Show full configuration
aztfexport config show

# Get a specific config item
aztfexport config get telemetry_enabled

# Set a config item
aztfexport config set telemetry_enabled false
```

**Config items:**
- `installation_id`: UUID for telemetry identification
- `telemetry_enabled`: Enable/disable telemetry (default: true)

## Additional Resources

- aztfexport GitHub: https://github.com/Azure/aztfexport
- aztfexport Documentation: https://azure.github.io/aztfexport/
- Microsoft Learn - Azure Export Overview: https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-terraform-overview
- Microsoft Learn - Concepts: https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-terraform-concepts
- Microsoft Learn - Advanced Scenarios: https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-advanced-scenarios
- Terraform AzureRM Provider: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
- Terraform AzAPI Provider: https://registry.terraform.io/providers/Azure/azapi/latest/docs
- Azure Resource Graph Query: https://learn.microsoft.com/en-us/azure/governance/resource-graph/
- aztft (Resource Type Identification): https://github.com/magodo/aztft
- tfadd (Config Generation): https://github.com/magodo/tfadd

---

**Note to GitHub Copilot**: Use this guide to provide accurate, context-aware assistance when users work with Azure resources and Terraform. Always prioritize the user's specific needs and the current state of their environment. Be aware of the limitations and guide users appropriately when generated code needs manual refinement.

# Utilities and Ancillary Tasks

## Generating Random Strings

Use /dev/urandom to generate random strings when needed.  For example to generate an 8 character alphanumeric string:

```bash
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1
```

## Temporary Directories

When you need to create temporary directories for intermediate processing, use `mktemp -d` to ensure a unique and secure temporary directory. For example:

```bash
temp_dir=$(mktemp -d)
# Use $temp_dir for your temporary files
# Clean up when done
rm -rf "$temp_dir"
```

Temp directories should be named "temp_xxxxxxxx" where "xxxxxxxx" is a random alphanumeric string.
