# About

This is the Azure IaC Agentic Toolkit.

This project combines open-source tools with [GitHub Copilot](Documentation/GitHub%20Copilot.md) agentic configurations to help you to build Azure-based infrastructure with [Terraform](Documentation/Terraform.md) and to reverse engineer Azure resources created using [click-ops](Documentation/Click-Ops.md) into [Infrastructure-as-Code (IaC)](Documentation/Infrastructure-as-Code%20(IaC).md).

This project lives on GitHub at: [microsoft/azure-iac-agentic-toolkit](https://github.com/microsoft/azure-iac-agentic-toolkit).

# Environment

## Overview

This project provides a ready to use environment built on [Dev Containers](Documentation/Dev%20Containers.md).  See the Dev Container definition at `.devcontainer/devcontainer.json`.

Tools that this Dev Container includes into the environment are:
- [aztfexport](Documentation/aztfexport.md)
- [Terraform](Documentation/Terraform.md)
- [GitHub Copilot](Documentation/GitHub%20Copilot.md)

## [aztfexport](Documentation/aztfexport.md)

### Usage Telemetry Collection Opt-Out

By default, Azure Export for Terraform collects telemetry data. However, you can easily disable this process - see:

https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-terraform-overview#data-collection-disclosure

The Dev Container opts out for you with the `postCreateCommand`:

```json
  "postCreateCommand": "go install github.com/Azure/aztfexport@v0.18.0 && aztfexport config set telemetry_enabled false",
```

# Tool Usage

## [aztfexport](Documentation/aztfexport.md)

We suggest walking through the [quickstart](https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-first-resources) to understand the loop of exporting existing resources with `tfstate` that matches the deployed resources.

# Agentic Prompts

## Overview

| Prompt             | Context                                       | Description |
| ------------------ | --------------------------------------------- | ----------- |
| `/export-resource` | The name of the [[Resource Group]] to export. |             |
|                    |                                               |             |

# Notes on Resource Types

## AI Foundry Resources

https://learn.microsoft.com/en-us/azure/ai-foundry/how-to/create-resource-terraform?tabs=azapi


