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
├── terraform/
│   └── dynamodb/
│       ├── main.tf              # DynamoDB table definitions
│       ├── variables.tf         # Input variables
│       ├── outputs.tf           # Output values
│       └── environments/
│           └── dev.tfvars       # DEV environment config
├── scripts/
│   └── validate_dynamodb_dev.py # Validation script
└── .github/
    └── workflows/
        └── deploy-dev.yml       # CI/CD pipeline
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
