# PipeRE Build Automation (PIPE-6071)

Automated CI/CD pipeline for the PipeRE Salesforce 2GP package.

## Workflows

### PipeRE Build (`pipere-build.yml`)

Fully automated build pipeline triggered manually via `workflow_dispatch`.

**Build Sequence:**
1. Install Node.js (v24.16.x) and Salesforce CLI
2. Authenticate to DevHub via JWT
3. Perform namespace replacements (configurable, see PIPE-6072)
4. Calculate next package version number (see PIPE-6073)
5. Create 2GP package version (with code coverage)
6. Promote package to Released
7. Install package into PipeRE QA org

### Salesforce Validation (`build.yml`)

Runs on pull requests to `main`. Performs delta deployment validation.

## Required GitHub Configuration

### Secrets

| Secret | Description |
|--------|-------------|
| `SF_JWT_KEY` | Private key (PEM) for DevHub JWT auth |
| `SF_CONSUMER_KEY` | Connected App consumer key for DevHub |
| `SF_QA_JWT_KEY` | Private key (PEM) for QA org JWT auth |
| `SF_QA_CONSUMER_KEY` | Connected App consumer key for QA org |

### Variables

| Variable | Description |
|----------|-------------|
| `PIPERE_PACKAGE_ID` | The 2GP Package ID (starts with `0Ho`) |
| `SF_DEVHUB_USERNAME` | DevHub org username |
| `SF_DEVHUB_URL` | DevHub instance URL (e.g., `https://login.salesforce.com`) |
| `SF_QA_USERNAME` | QA org username |
| `SF_QA_URL` | QA org instance URL |

## Scripts

### `scripts/namespace-replace.sh`

Reusable namespace replacement script. Configured via `scripts/namespace-config.json`.

Edit `namespace-config.json` to define patterns:

```json
{
  "replacements": [
    {
      "description": "Replace namespace placeholder",
      "pattern": "__NAMESPACE__",
      "replacement": "pipere",
      "extensions": "cls,trigger,xml,js,html"
    }
  ]
}
```

### `scripts/calculate-version.sh`

Calculates next version number based on existing released versions. Uses date-based patch numbering (YYMM + day + build number).

## Running the Build

1. Go to **Actions** tab in GitHub
2. Select **PipeRE Build Automation**
3. Click **Run workflow**
4. Configure options:
   - Skip namespace replacement (default: false)
   - Target QA org alias (default: PipeRE-QA)
   - Promote to Released (default: true)
5. Click **Run workflow**

## Local Development

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
