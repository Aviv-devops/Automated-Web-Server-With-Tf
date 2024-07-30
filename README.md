# Automated Web Werver With Terraform
Use Terraform to create a Nginx web server with an automated cloud environment that creates all you need to set up a web machine using: VPC, EC2, security group, rout table, IGW, option to connect the Nginx instance with SSH, and more.

# Project README

## Overview

This project sets up an EC2 instance using Terraform and configures it to run an Nginx web server with a custom HTML page. The setup includes the following Terraform and shell script files:

- `main.tf`
- `provider.tf`
- `userdata.sh`
- `variables.tf`
- `index.html`

## Files

### `main.tf`

This file contains the main configuration for your Terraform setup. It defines the AWS resources, including the EC2 instance. It uses the settings and variables defined in other files to configure the resources appropriately.

### `provider.tf`

This file specifies the provider for Terraform, which is AWS in this case. It includes configuration details for interacting with AWS, such as region and credentials.

### `userdata.sh`

This is a shell script executed during the launch of the EC2 instance. It installs Nginx, configures permissions, and copies a custom `index.html` file to the web server directory. **Note:** This script assumes that Nginx is used and that the instance uses Amazon Linux. Ensure that the Nginx path and permissions are set correctly.

### `variables.tf`

This file defines the variables used in the Terraform configuration. It includes variable definitions for things like AWS region, AMI ID, and key pair information.

### `index.html`

This file contains the HTML content for the web page served by Nginx. **Note:** This HTML file does not support images. Ensure that all references to images are removed or handled separately.

## Variables

The `variables.tf` file includes the following variables:

| Variable Name            | Type    | Description                                         | Required |
|--------------------------|---------|-----------------------------------------------------|----------|
| `key-pair`                | string  | The name of the AWS key pair used for SSH access.  | Yes      |
| `full-path-of-key-pair`  | string  | The full local path to the AWS key pair file.      | Yes      |
| `aws-region`             | string  | The AWS region where resources will be created.    | No       |
| `aws-ami-of-region`      | string  | The AMI ID for Amazon Linux in the specified region. | No       |

**Note:** Ensure that `aws-ami-of-region` corresponds to an Amazon Linux image. If using a different image, adjustments to the `userdata.sh` script may be required.

## Running the Terraform Configuration

To apply the Terraform configuration and set up the EC2 instance, follow these steps:

1. **Initialize Terraform:**
initializes Terraform, downloading the necessary provider plugins.
   ```bash
   terraform init

2. **Review the Terraform Plan::** 
generates and shows an execution plan, allowing you to review the changes Terraform will make.
   ```bash
   terraform plan

3. **Apply the Configuration::**
applies the changes required to reach the desired state of the configuration.
   ```bash
   terraform apply

Note: The IP address of the EC2 instance is not static and will change every time the instance is restarted or recreated.

## Last step
To you the web page copy the public IP of the instance and past it in the URL of your internet browser.
