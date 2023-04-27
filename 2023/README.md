# Terraform

## [Task1](https://github.com/Nitesh-Sen/Terraform_code/blob/49c0e4844846301e5f97c9997a7fd84594d6a7e1/2023/Task1/REDME.md)
> Launch EC2 
>
> - Give tag by Variable 
>
> Create S3 Bucket
> 
> - Give tag:- Owner = "INSTANCE_ID"
>
> Output
>
> - Instance ID, Name
> 
> - S3 Bucket Name

<br />


## [Task2](https://github.com/Nitesh-Sen/Terraform_code/blob/49c0e4844846301e5f97c9997a7fd84594d6a7e1/2023/Task2/REDME.md)
> Launch EC2 
>
> - Give tag by Variable 
>
> - Security Group 80
> 
> - Run Nginx with other file script. Give the location in main.tf file
> 
> - In Nginx .html file add data. - ``<h1>{Hello from Terraform}</h1>``

<br />

## [Task3](https://github.com/Nitesh-Sen/Terraform_code/tree/main/2023/Task3)
> Create Custom VPC
>
> - 1 Private Subnet each Availability zone [Max Availability zone 2] [Total Subnet 2].
>
> - 1 Public Subnet in each Availability zone [Max Availability zone 2] [Total Subnet 2].
>
> - Internet Gateway and Attach with all Public Subnet.
>
> Launch EC2 with Custom VPC
>
> - Give SG (80, 22) to All.
>
> - Run Nginx by script.
>
> - Get Public IP in Output and open it on Browser. ( To Check your all VPC Configuration and all Network is working well).
> 
-  **NOTE:- Use Count, For Each metadata and Use Variable, Tag and Data for get or filter latest ubuntu ami.**

<br />

## [Task4](https://github.com/Nitesh-Sen/Terraform_code/tree/main/2023/Task4)

> Create Custom VPC
>
> - 2 Private Subnet each Availability zone [Max Availability zone 2] [Total Subnet 4].
>
> - 2 Public Subnet in each Availability zone [Max Availability zone 2] [Total Subnet 4].
>
> - 1 Internet Gateway and Attach with all Public Subnet.
>
> Launch EC2 with Custom VPC
>
> - Give SG (80, 22) to All.
>
> - Run Apache2 by script.
>
> - Get Public IP in Output and open it on Browser. ( To Check your all VPC Configuration and all Network is working well).
- **NOTE:-** Without use any count and For each metadata. Create the simply template with these following steps.
