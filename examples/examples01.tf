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