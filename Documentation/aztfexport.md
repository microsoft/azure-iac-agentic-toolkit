- https://github.com/Azure/aztfexport
- https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-terraform-overview
- https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-advanced-scenarios

# Getting Started with aztfexport

We suggest walking through the [quickstart](https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-first-resources) to understand the loop of exporting existing resources with `tfstate` that matches the deployed resources.

# Export a Resource Group

Abstract form:

```
aztfexport resource-group [options] <resource-group-name>
```

Example invocation:

```bash
aztfexport resource-group -o terraform_azapi --non-interactive --provider-name=azapi llmtest
```

References:
- https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-terraform-overview#usage
- https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-first-resources?tabs=azure-cli#export-an-azure-resource

# Interactive Mode with [azapi](Terraform.md#azapi-Provider):

```bash
aztfexport resource-group -o terraform_azapi --provider-name=azapi <name>
```

# Export an AI Foundry (not a Hub)

Example invocation using [azapi](Terraform.md#azapi-Provider):

```bash
aztfexport resource -o terraform_azapi --non-interactive --provider-name=azapi /subscriptions/<sub_id>/resourceGroups/<resource_group_name>/providers/Microsoft.CognitiveServices/accounts/<ai_foundry_name>
```

References:
- https://learn.microsoft.com/en-us/azure/ai-foundry/how-to/create-resource-terraform?tabs=azapi

# Export an AI Foundry (not a Hub) Project

Example invocation using [azapi](Terraform.md#azapi-Provider):

```
aztfexport resource -o terraform_azapi --non-interactive --provider-name=azapi --append /subscriptions/<sub_id>/resourceGroups/<resource_group_name>/providers/Microsoft.CognitiveServices/accounts/<ai_foundry_name>/projects/<project_name>
```
