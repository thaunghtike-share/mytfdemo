## Deployment

```sh
terraform init
terraform plan
terraform apply -auto-approve
```

## Tier down

```sh
terraform destroy -auto-approve
```
## Usage

``` sh
ssh-keygen -t rsa
```


``` sh
module "bastion" {
  source = "github.com/opszero/terraform-aws-bastion"

  ssh_keys = [
     "ssh-rsa ..."
  ]
}
```
