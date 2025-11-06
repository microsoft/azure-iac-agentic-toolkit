# About

This is the Azure IaC Agentic Toolkit.

This project combines open-source tools with [GitHub Copilot](Documentation/GitHub%20Copilot.md) agentic configurations to help you to build Azure-based infrastructure with [Terraform](Documentation/Terraform.md) and to reverse engineer Azure resources created using [click-ops](Documentation/Click-Ops.md) into [Infrastructure-as-Code (IaC)](Documentation/Infrastructure-as-Code%20(IaC).md).

This project lives on GitHub at: [microsoft/azure-iac-agentic-toolkit](https://github.com/microsoft/azure-iac-agentic-toolkit).

# Environment

This project provides a ready to use environment built on [Dev Containers](Documentation/Dev%20Containers.md).  Tools included in the environment are:
- [Azure CLI](Documentation/Azure%20CLI.md)
- [Terraform](Documentation/Terraform.md)
- [aztfexport](Documentation/aztfexport.md)
- [GitHub Copilot](Documentation/GitHub%20Copilot.md)

For a detailed explanation of the environment setup refer to [Environment](Documentation/Environment.md).

# Using this Toolkit

## Introduction

This toolkit is intended to be run in [Visual Studio Code](Documentation/Visual%20Studio%20Code.md) within a [Dev Containers](Documentation/Dev%20Containers.md).  You can use this toolkit to generate or reverse engineer [Terraform](Documentation/Terraform.md) templates, then move those templates to your project repository.

## Open the Project

Open the folder in Visual Studio Code.

## Launching the Dev Container

To launch the Dev Container use the key chord `Ctrl+D Ctrl+C` or press F1 and select **Dev Containers: Reopen in Container**:

![](Documentation/_img/open_dev_container.png)

## Authenticate to Azure

- Open a terminal in Visual Studio Code
- Invoke the following command:

```bash
az login
```

# Notes on Resource Types

## AI Foundry Resources

https://learn.microsoft.com/en-us/azure/ai-foundry/how-to/create-resource-terraform?tabs=azapi


