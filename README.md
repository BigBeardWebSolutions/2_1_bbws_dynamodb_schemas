# BBWS DynamoDB Infrastructure

DynamoDB tables for BBWS multi-tenant platform.

## Tables

- **tenants** - Organizations and user management (3 GSIs)
- **products** - Subscription tiers and features (2 GSIs)
- **campaigns** - Marketing campaigns (3 GSIs)

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
└── README.md                        # This file
```

## Deployment

Deployment is automated via GitHub Actions.

### Trigger Deployment

1. Go to **Actions** tab in GitHub
2. Select **Deploy to DEV** workflow
3. Click **Run workflow**
4. Select component: `dynamodb`
5. Click **Run workflow**

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

## Features

- ✅ PAY_PER_REQUEST billing mode (on-demand)
- ✅ Point-in-Time Recovery enabled
- ✅ DynamoDB Streams enabled (NEW_AND_OLD_IMAGES)
- ✅ 8 Global Secondary Indexes across 3 tables
- ✅ Multi-environment support (DEV/SIT/PROD)
- ✅ Automated deployment via GitHub Actions
- ✅ Post-deployment validation
