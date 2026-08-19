# AWS ECS Infrastructure with Terraform

This project provisions the initial AWS infrastructure required to run a containerized application using **Amazon ECS with AWS Fargate**.

The infrastructure is designed using reusable Terraform modules and separate environment configurations (`dev`, `qa`, `uat`, `prd`).

## Architecture

The current architecture uses public subnets only. ECS tasks run on **AWS Fargate**, so no EC2 instances or NAT Gateways are required.

```text
                         Internet
                            │
                            ▼
                  ┌──────────────────┐
                  │ Internet Gateway │
                  └────────┬─────────┘
                           │
                           ▼
                  ┌─────────────────────┐
                  │        VPC          │
                  │    10.10.0.0/16     │
                  │       DEV           │
                  └─────────┬───────────┘
                            │
                 ┌──────────┴──────────┐
                 │                     │
                 ▼                     ▼
        ┌────────────────┐    ┌────────────────┐
        │ Public Subnet  │    │ Public Subnet  │
        │  10.10.1.0/24  │    │  10.10.2.0/24  │
        │   us-east-1a   │    │   us-east-1b   │
        └────────┬───────┘    └───────┬────────┘
                 │                    │
                 └──────────┬─────────┘
                            │
                            ▼
                  ┌──────────────────┐
                  │   ECS Cluster    │
                  │     Fargate      │
                  └────────┬─────────┘
                           │
                           ▼
                  ┌──────────────────┐
                  │   ECS Service   │
                  └────────┬─────────┘
                           │
                           ▼
                  ┌──────────────────┐
                  │   Fargate Task   │
                  │  .NET Container   │
                  └────────┬─────────┘
                           │
                           ▼
                  ┌──────────────────┐
                  │       ECR        │
                  │ Container Image  │
                  └──────────────────┘
```

## AWS Resources

The Terraform configuration creates:

* **Amazon VPC**

  * CIDR: `10.10.0.0/16` for `dev`
  * Two public subnets
  * `us-east-1a`: `10.10.1.0/24`
  * `us-east-1b`: `10.10.2.0/24`
  * Internet Gateway
  * Public route table
* **Amazon ECR**

  * Container image repository
  * Image scanning enabled
  * Lifecycle policy
* **Amazon ECS**

  * ECS Cluster
  * ECS Service
  * Fargate Task Definition
  * CloudWatch Log Group
  * ECS Security Group
* **AWS IAM**

  * ECS Task Execution Role
  * ECS Task Role
* **Amazon S3**

  * Remote Terraform state

### Fargate

ECS uses:

```text
launch_type = "FARGATE"
```

and:

```text
network_mode = "awsvpc"
```

Tasks receive public IP addresses because they run in public subnets:

```text
assign_public_ip = true
```

No EC2 instances or NAT Gateway are required.

## Project Structure

```text
terraform/
├── environments/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   └── outputs.tf
│   │
│   ├── qa/
│   ├── uat/
│   └── prd/
│
├── modules/
│   ├── vpc/
│   ├── ecr/
│   ├── iam/
│   └── ecs/
│
├── .gitignore
└── README.md
```

## Terraform State

Terraform state is stored remotely in Amazon S3.

Each environment will have an independent state:

```text
gimnasio/
├── dev/terraform.tfstate
├── qa/terraform.tfstate
├── uat/terraform.tfstate
└── prd/terraform.tfstate
```

The S3 bucket must exist before running `terraform init`.

## Prerequisites

Install and configure:

* Terraform
* AWS CLI
* An AWS account with the required permissions

Verify AWS credentials:

```bash
aws sts get-caller-identity
```

## Deploy the DEV Environment

Terraform commands must be executed from the environment directory.

```bash
cd environments/dev
```

### 1. Initialize Terraform

```bash
terraform init
```

This initializes the AWS provider, Terraform modules, and the S3 backend.

### 2. Format the configuration

```bash
terraform fmt -recursive
```

### 3. Validate the configuration

```bash
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

### 4. Create a Terraform plan

```bash
terraform plan -out=tfplan
```

Review the resources that Terraform plans to create.

### 5. Apply the approved plan

```bash
terraform apply tfplan
```

Alternatively:

```bash
terraform apply
```

## View Terraform Outputs

After deployment:

```bash
terraform output
```

To retrieve a specific output:

```bash
terraform output ecr_repository_url
```

## Destroy the DEV Environment

To remove all resources managed by this environment:

```bash
terraform destroy
```

Review the destruction plan carefully before confirming.

## Environment Strategy

The same reusable modules are used across all environments.

Only environment-specific configuration changes:

```text
modules/
    └── Reusable infrastructure

environments/
    ├── dev/   → Development
    ├── qa/    → Quality Assurance
    ├── uat/   → User Acceptance Testing
    └── prd/   → Production
```

Each environment will have its own:

* Terraform configuration
* `terraform.tfvars`
* S3 state key
* AWS resource naming
* Infrastructure sizing

## CI/CD Integration

The infrastructure is designed to integrate with GitHub Actions.

The expected application deployment flow is:

```text
Developer
    │
    ▼
GitHub
    │
    ▼
GitHub Actions
    │
    ├── Build .NET application
    ├── Build Docker image
    ├── Push image to ECR
    │
    ▼
ECR
    │
    ▼
Update ECS Task Definition
    │
    ▼
ECS Fargate Service
```

Terraform is responsible for provisioning the infrastructure, while GitHub Actions will later be responsible for building and deploying new application images.
