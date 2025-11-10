# About

This is the **Azure IaC Agentic Toolkit**.

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

## Export Resources to Terraform

The `/export-stack` agentic prompt does its best to generate Terraform templates for the Azure resources you want to export.

Note that the export will likely have errors but we will address those later with the `/testfix-stack` agentic prompt.

> [!NOTE] Note
> In the current version `/export-stack` has been tested for exporting resource groups, AI Foundry accounts and AI Foundry projects.  It may or may not work well with other resource types but we are continuing to extend and evaluate the capabilities of this feature.

- Open GitHub Copilot Chat
- Ensure that it is set to Agent Mode
- Trigger the `/export-stack` agentic prompt:

![](Documentation/_img/export-stack.png)

- When prompted specify the name of the resource group that you want to export and optionally the names of any specific resources:

![](Documentation/_img/export-stack_specify_resource_group.png)

- The agent will attempt to discover the resources that you want to export and will then check with you if it has got the list of resources correct:

![](Documentation/_img/export-stack_discovery_complete.png)

- If the list of resources it has discovered is complete and correct then you can simply confirm - otherwise you can tell the agent what else it should look for, or any resources that should be excluded.  In this case we are ready to proceed so we can simply answer "Yes":

![](Documentation/_img/export-stack_confirm.png)

- You may be prompted to allow the agent to clean up directories that it will use:

![](Documentation/_img/export-stack_allow_rm.png)

- The agent will proceed to run exports and assemble a complete stack, prompting you from time to time to allow certain critical commands to be performed:

![](Documentation/_img/export-stack_working.png)

# Trademark Notice

Trademarks This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft trademarks or logos is subject to and must follow Microsoft’s Trademark & Brand Guidelines. Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship. Any use of third-party trademarks or logos are subject to those third-party’s policies.
