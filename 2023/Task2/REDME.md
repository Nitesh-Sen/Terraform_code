# Terraform

> Launch EC2 
>
> - Give tag by Variable 
>
> - Security Group 80
> 
> - Run Nginx with other file script. Give the location in main.tf file
> 
> - In Nginx .html file add data. - ``<h1>{Hello from Terraform}</h1>``

Save both file in one Repository and run following commands. 
  - [Bash.sh ](https://github.com/Nitesh-Sen/Terraform_code/blob/8b126da0e5652d71a4cb6bca8846fdc5db5dfba2/2023/Task2/user-data.web)
  - [main.tf](https://github.com/Nitesh-Sen/Terraform_code/blob/8b126da0e5652d71a4cb6bca8846fdc5db5dfba2/2023/Task2/main2.tf)

- Configure your aws credentials.
```
aws configure
```

- check your aws credentials.
```
aws sts get-caller-identity
```
```
{
    "UserId": "AXXXXXXXXXXXXXXXXW",
    "Account": "428918830755",
    "Arn": "arn:aws:iam::4XXXXXXXXX5:user/nitesh"
}
```
> if you get this output then your credentials are working.
- Initialize the repository.
```
terraform init
```
- Validate the Terraform code. 
```
terraform validate
```

- Set the format of Terraform code.
```
terraform fmt
```

- Check the code. What it will build.
```
terraform plan
```

- Now go to apply the Terraform code. if this code is validate.
```
terraform apply
```

- Forcefully apply code.
```
terraform apply --auto-approve
```
- To destroy all resources which were created.
```
terraform destroy
```
