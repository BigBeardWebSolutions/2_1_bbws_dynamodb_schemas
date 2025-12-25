# BBWS DynamoDB Infrastructure

DynamoDB tables for BBWS multi-tenant platform.

## Tables

- **tenants** - Organizations and user management
- **products** - Subscription tiers and features
- **campaigns** - Marketing campaigns

## Environments

| Environment | AWS Account | Region |
|-------------|-------------|--------|
| DEV | 536580886816 | eu-west-1 |
| SIT | 815856636111 | eu-west-1 |
| PROD | 093646564004 | af-south-1 (primary), eu-west-1 (DR) |

## Directory Structure

```
.
├── .github/
│   └── workflows/
│       └── deploy-dev.yml           # GitHub Actions deployment workflow
├── terraform/
│   └── dynamodb/
│       ├── main.tf                  # DynamoDB table definitions
│       ├── variables.tf             # Input variables
│       ├── outputs.tf               # Output values
│       └── environments/
│           └── dev.tfvars           # DEV environment config
├── scripts/
│   └── validate_dynamodb_dev.py     # Post-deployment validation
├── 0-create-repository.sh           # (Not needed - repo exists)
├── 1-setup-aws-profile.sh           # One-time: Configure AWS CLI
├── 2-setup-aws-infrastructure.sh    # One-time: Create OIDC, IAM role, S3, DynamoDB
├── 3-setup-github.sh                # One-time: Configure GitHub secrets
├── 4-trigger-deployment.sh          # Trigger and monitor deployment
├── check-setup.sh                   # Diagnostic: Check what's configured
├── SETUP_GUIDE.md                   # Quick setup guide (15 min)
├── AUTOMATED_SETUP.md               # Detailed setup instructions
└── README.md                        # This file
```

## Quick Start

### First-Time Setup (15 minutes)

Run these scripts in order:

```bash
# Step 1: Configure AWS CLI profile for DEV
./1-setup-aws-profile.sh

# Step 2: Create AWS infrastructure (OIDC, IAM role, S3, DynamoDB)
./2-setup-aws-infrastructure.sh BigBeardWebSolutions

# Step 3: Configure GitHub secrets and copy workflow files
./3-setup-github.sh BigBeardWebSolutions 2_1_bbws_dynamodb_schemas

# Step 4: Trigger deployment and monitor progress
./4-trigger-deployment.sh BigBeardWebSolutions 2_1_bbws_dynamodb_schemas dynamodb
```

See `SETUP_GUIDE.md` for detailed instructions.

### Check Current Setup

```bash
./check-setup.sh BigBeardWebSolutions 2_1_bbws_dynamodb_schemas
```

## Deployment

Deployment is automated via GitHub Actions. See `.github/workflows/deploy-dev.yml`

### Manual Deployment

```bash
cd terraform/dynamodb
terraform init
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```

## Validation

```bash
python3 scripts/validate_dynamodb_dev.py
```

## Documentation

- [LLD Document](../2_bbws_docs/LLDs/2.1.8_LLD_S3_and_DynamoDB.md)
- [Setup Guide](../2_bbws_docs/LLDs/project-plan-1/github-workflows-ready-to-deploy/AUTOMATED_SETUP.md)
