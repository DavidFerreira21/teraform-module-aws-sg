
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.70.0 |
# Examples

``` hcl
module "sg_front-end" {
  source = "../modules/sg"

  sg_name        = var.sg_name_front-end
  sg_description = var.sg_description_front-end
  vpc_id         = module.vpc.vcp_id

  rules_sg = {

    HTTPS_ALB = {
      type                     = "ingress"
      description              = "test"
      from_port                = 443
      protocol                 = "TCP"
      to_port                  = 443
      source_security_group_id = module.sg_ALB.sg_id
    },
    HTTP_ALB = {
      type                     = "ingress"
      description              = "test"
      from_port                = 80
      protocol                 = "TCP"
      to_port                  = 80
      source_security_group_id = module.sg_ALB.sg_id
    },
    Toncat = {
      type                     = "ingress"
      description              = "Allow Toncat"
      from_port                = 8608
      protocol                 = "TCP"
      to_port                  = 8608
      source_security_group_id = module.sg_content_manager.sg_id
    },
    Toncat_1 = {
      type                     = "ingress"
      description              = "Allow Toncat"
      from_port                = 8609
      protocol                 = "TCP"
      to_port                  = 8609
      source_security_group_id = module.sg_content_manager.sg_id
    },
    Toncat_2 = {
      type                     = "ingress"
      description              = "Allow Toncat"
      from_port                = 8080
      protocol                 = "TCP"
      to_port                  = 8080
      source_security_group_id = module.sg_content_manager.sg_id
    },
    Solr = {
      type                     = "ingress"
      description              = "Allow solr"
      from_port                = 8984
      protocol                 = "TCP"
      to_port                  = 8984
      source_security_group_id = module.sg_content_manager.sg_id
    }

  }

  rules_cidr = {

    SSH = {
      type        = "ingress"
      description = "Allow SSH"
      from_port   = 22
      protocol    = "TCP"
      to_port     = 22
      cidr_blocks = var.remote_ipv4_network_cidr
    },
    Internet = {
      type        = "egress"
      description = "Allow internet"
      from_port   = 0
      protocol    = -1
      to_port     = 0
      cidr_blocks = "0.0.0.0/0"
    }
  }

}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc id for SG | `string` | n/a | yes |
| <a name="input_rules_cidr"></a> [rules\_cidr](#input\_rules\_cidr) | Maps of rules for SG , this variable is use just with attribute cidr\_blocks (not work with source\_security\_group\_id) | `map(map(any))` | `{}` | no |
| <a name="input_rules_sg"></a> [rules\_sg](#input\_rules\_sg) | Maps of rules for SG , this variable is use just with attribute source\_security\_group\_id (not work with cidr\_blocks) | `map(map(any))` | `{}` | no |
| <a name="input_sg_description"></a> [sg\_description](#input\_sg\_description) | Description for SG | `string` | `""` | no |
| <a name="input_sg_name"></a> [sg\_name](#input\_sg\_name) | name for SG | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Maps of tags | `map(any)` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_id"></a> [sg\_id](#output\_sg\_id) | string to sg id |
## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.rules_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.rules_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

