# Introduction

Terraform is an open-source [[Infrastructure-as-Code (IaC)]] tool that automates the provisioning and management of cloud and on-prem resources using declarative configuration files.

https://developer.hashicorp.com/terraform

# Providers

## azurerm Provider

The Terraform AzureRM provider is a plugin developed and maintained by HashiCorp and Microsoft that enables you to manage and provision resources within Microsoft Azure using HashiCorp Configuration Language (HCL). It acts as a bridge between your Terraform configurations and the Azure Resource Manager (ARM) APIs, providing a stable, well-tested, and simplified interface for infrastructure as code (IaC). 

- Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
- GitHub repository: https://github.com/hashicorp/terraform-provider-azurerm

## azapi Provider

The Terraform AzAPI provider is a lightweight layer over the Azure ARM (Azure Resource Manager) REST APIs that enables immediate access to new or preview Azure services and features not yet supported by the standard azurerm provider. It is designed to complement, not replace, the azurerm provider, ensuring full compatibility with the Terraform ecosystem. 

- Documentation (HashiCorp): https://registry.terraform.io/providers/Azure/azapi/latest/docs
- Documentation (Microsoft): https://learn.microsoft.com/en-us/azure/developer/terraform/overview-azapi-provider
s