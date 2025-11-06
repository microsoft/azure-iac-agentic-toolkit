# Overview

This project provides a ready to use environment built on [Dev Containers](Documentation/Dev%20Containers.md).  See the Dev Container definition at `.devcontainer/devcontainer.json`.

Tools that this Dev Container includes into the environment are:
- [Azure CLI](Azure%20CLI.md)
- [Terraform](Documentation/Terraform.md)
- [aztfexport](Documentation/aztfexport.md)
- [GitHub Copilot](Documentation/GitHub%20Copilot.md)

# [Azure CLI](Azure%20CLI.md)

The Azure CLI is installed via the Dev Container [feature plugin](https://github.com/devcontainers/features/tree/main/src/azure-cli):

```json
"features": {
    "ghcr.io/devcontainers/features/azure-cli:1": {}
}
```

# [Terraform](Documentation/Terraform.md)

Terraform is installed via the Dev Container [feature plugin](https://github.com/devcontainers/features/tree/main/src/terraform):

```json
"features": {
    "ghcr.io/devcontainers/features/terraform:1": {}
}
```

# [aztfexport](Documentation/aztfexport.md)

## Installation

`aztfexport` is installed in the Dev Container via the following statement in the `postCreateCommand`:

```
go install github.com/Azure/aztfexport@v0.18.0
```

## Usage Telemetry Collection Opt-Out

By default, Azure Export for Terraform collects telemetry data. However, you can easily disable this process - see:

https://learn.microsoft.com/en-us/azure/developer/terraform/azure-export-for-terraform/export-terraform-overview#data-collection-disclosure

The Dev Container opts out for you with the following statement in the `postCreateCommand`:

```
aztfexport config set telemetry_enabled false
```

# [GitHub Copilot](Documentation/GitHub%20Copilot.md)

