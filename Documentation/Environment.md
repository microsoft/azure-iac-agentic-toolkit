# Overview

This project provides a ready to use environment built on [Dev Containers](Dev%20Containers.md).  See the Dev Container definition at `.devcontainer/devcontainer.json`.

Tools that this Dev Container includes into the environment are:
- [Azure CLI](Azure%20CLI.md)
- [Terraform](Terraform.md)
- [aztfexport](aztfexport.md)
- [GitHub Copilot](GitHub%20Copilot.md)

# [Azure CLI](Azure%20CLI.md)

The Azure CLI is installed via the Dev Container [feature plugin](https://github.com/devcontainers/features/tree/main/src/azure-cli):

```json
"features": {
    "ghcr.io/devcontainers/features/azure-cli:1": {}
}
```

# [Terraform](Terraform.md)

Terraform is installed via the Dev Container [feature plugin](https://github.com/devcontainers/features/tree/main/src/terraform):

```json
"features": {
    "ghcr.io/devcontainers/features/terraform:1": {}
}
```

# [aztfexport](aztfexport.md)

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

# [GitHub Copilot](GitHub%20Copilot.md)

One of the goals of this project is to make the task of engineering and reverse-engineering Terraform stacks for Azure as automated as possible.  With that in mind we have configured GitHub Copilot with certain settings to allow for a relatively hands-off experience.

We set the maximum turns for Agent mode to 100 (the default is 25) in `.vscode/settings.json`:

```json
{
    "chat.agent.maxRequests": 100,
}
```

We enable auto approve for certain non-destructive commands so that Agent mode can proceed without you needing to click the Allow button constantly.  This is also done in `.vscode/settings.json`:

```json
{
    "chat.tools.terminal.autoApprove": {
        "/^az account/i": true,
        "/^az resource/i": true,
        "/^az rest\\b.*--method GET\\b/i": true,
        "/^az cognitiveservices/i": true,
        "/^az graph/i": true,
        "/^az group\\b.*show\\b/i": true,
        "/^aztfexport/i": true,
        "/^terraform\\b.*(output|plan|show|validate)\\b/i": true,
        "/^bash gen_random.sh( \\d+)?$/i": true,
        "/^./scripts/gen_random.sh/i": true,
        "/^bash scripts/gen_random.sh/i": true,

        ...

}
```
