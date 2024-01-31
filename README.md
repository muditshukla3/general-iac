# Introduction
This repository contains terraform scripts for following:

- Create a VPC
- Attach a Internet Gateway
- Create a Custom Route Table
- Create a subnet and attach the route table
- Create a security group to allow port 22, 80, 443
- Create Auto scaling group using launch templates.
- Create Application load balancer.
- Create EC2 instances backed by auto scaling group running web server.

Before running terraform scripts make sure to set ACCESS_KEY_ID and SECRET_ACCESS_KEY as environment variable using the following command:

```
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
```