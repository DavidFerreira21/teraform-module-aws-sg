#########################################################################################
# Security Group
#########################################################################################

resource "aws_security_group" "this" {
  count       = length(var.sg_name) > 0 ? 1 : 0 # somente executa caso tiver uma variavel nome definida
  name        = var.sg_name                     # nome do SG
  description = var.sg_description              # Description do SG
  vpc_id      = var.vpc_id                      # VPC id do SG

  tags = merge(
    {
      "Name" = format("%s", var.sg_name)
    },
    var.tags,
  )
}


resource "aws_security_group_rule" "rules_sg" {
  for_each                 = var.rules_sg
  type                     = each.value.type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = each.value.source_security_group_id
  security_group_id        = aws_security_group.this[0].id
  description              = lookup(each.value, "description", null)
}

resource "aws_security_group_rule" "rules_cidr" {
  for_each                 = var.rules_cidr
  type                     = each.value.type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = [each.value.cidr_blocks]
  security_group_id        = aws_security_group.this[0].id
  description              = lookup(each.value, "description", null)

}