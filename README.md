# chef_docker

Provisions amazon ec2 insance with Docker and image dmkonst/fun_with_jenkins using Terraform and chef-zero provisioner

Before use terraform make sure that you have terraform_aws key , or create new one with command like
```
ssh-keygen -t rsa -b 4096 -f terraform_aws -N ""
```

To run terraform:
```
terraform apply -var 'aws_access_key=YUOR_AWS_ACCESS_KEY' -var 'aws_secret_key=YOUR_AWS_SECRET_KEY'
```
