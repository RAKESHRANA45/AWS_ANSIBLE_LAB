# AWS-Ansible-Lab-Setup

### Prerequisites:
---------------------------------
- Change the AWS Profile in `main.tf`
- Change the domain in `variables.tf`

### Start the Lab

```shell
$ terraform init
$ terraform apply -auto-approve
```

### Destroy the Lab

```shell
$ terraform destroy -auto-approve
```

### Author:
----------------------------------
```diff
 Dipaditya Das | https://twitter.com/dipadityadas
```