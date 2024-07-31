# AWS Lambda Daily Stocks Notifier  

## Background and Purpose  

This personal project is a fully serverless solution using AWS Lambda and EventBridge to send user-specified stock prices on a cron expression via ntfy.sh.

The entire application is provisioned with Terraform, including Lambda roles, policies, and cron expressions for EventBridge. There are more than a dozen dynamic variables that can be configured in terraform.tfvars to maximize infrastructure modularity and flexibility.

The purpose of this project is to practice infrastructure as code within a serverless context.

## Installation

Please ensure the following software are installed on your local machine:

- Python
- Terraform

No manual configuration is required to get this project working on AWS Cloud, as infrastructure provisioning and setup of application code are all handled through Terraform. The only exception is the initial AWS credential setup so that Terraform can access your account’s resources. It is highly recommended not to use the AWS root user.


## Usage

The following instructions assume that variable values in `./terraform/terraform.tfvars` have not been changed. You are free to modify them as you wish.

Navigate to the `./terraform` directory and run the following command in the terminal:

`terraform apply -auto-approve`  

When you see Terraform return `Apply complete!` in the shell, you will know that you have provisioned the resources successfully.

To tear down the cloud infrastructure in the future, run the following command in the `./terraform` directory in the terminal:

`terraform destroy -auto-approve`

## Screenshots/Demo

Screenshots will be added here shortly.

## Credits

All work in this GitHub repository is completed by me - Cyrus Chan. 
