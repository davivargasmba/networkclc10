name: Create terraform plan

on:
  pull_request:
    paths:
      - 'prod/**'

env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  AWS_SESSION_TOKEN: ${{ secrets.AWS_SESSION_TOKEN }}

jobs:
  plan-dev:
    name: 'terraform plan dev'
    runs-on: ubuntu-latest
    env:
      TF_WORKING_DIR: 'prod'

    defaults:
      run:
        shell: bash
        working-directory: ${{ env.TF_WORKING_DIR }}

    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1
        with:
          terraform_version: 0.15.5

      - name: Terraform fmt
        id: fmt
        run: terraform fmt -check

      - name: Terraform Init
        id: init
        run: terraform init

      - name: Terraform Validate
        id: validate
        run: terraform validate -no-color

      - name: Terraform Plan
        id: plandev
        run: terraform plan -no-color

      - uses: actions/github-script@v6
        if: github.event_name == 'pull_request'
        env:
          PLAN: "terraform\n${{ steps.plan.outputs.stdout }}"
        with:
          github-token: ${{ secrets.TOKEN_GITHUB }}
          script: |
            const output = `#### Terraform Format and Style 🖌\`${{ steps.fmt.outcome }}\`
            #### Terraform Initialization ⚙️\`${{ steps.init.outcome }}\`
            #### Terraform Validation 🤖\`${{ steps.validate.outcome }}\`
            <details><summary>Validation Output</summary>
      
            \`\`\`\n
            ${{ steps.validate.outputs.stdout }}
            \`\`\`
      
            </details>
      
            #### Terraform Plan 📖\`${{ steps.plan.outcome }}\`
      
            <details><summary>Show Plan</summary>
      
            \`\`\`\n
            ${process.env.PLAN}
            \`\`\`
      
            </details>
      
            *Pusher: @${{ github.actor }}, Action: \`${{ github.event_name }}\`, Working Directory: \`${{ env.tf_actions_working_dir }}\`, Workflow: \`${{ github.workflow }}\`*`;
      
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: output
            })