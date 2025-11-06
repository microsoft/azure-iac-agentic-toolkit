---
mode: agent
---
Your job is to test the deployment of the Terraform stack located in the terraform_final/ directory.

Ask the user for the Azure subscription ID and region to use for the test deployment.

Generate a resource group named rg-test-deployment-<random-suffix> using the script scripts/gen_random.sh.

Use the provided subscription ID, region, and generated resource group name to deploy the Terraform stack in terraform_final/.

If any issues are found then attempt to fix them and redeploy the stack.
