module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${local.ec2_name}-mongodb"
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id              = local.database_subnet_id
  tags = merge(
    var.common_tags,
    {
        component = "mongodb"
    },
    {
        name = "${local.ec2_name}-mongodb"
    }
  )
}

output "mongodb_private_ip" {
  value = module.ec2_instance.private_ip
}

module "redis" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-redis"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
  subnet_id              = local.database_subnet_id
  tags = merge(
    var.common_tags,
    {
      Component = "redis"
    },
    {
      Name = "${local.ec2_name}-redis"
    }
  )
}

output "redis_private_ip" {
  value = module.redis.private_ip
}

module "mysql" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-mysql"
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
  subnet_id              = local.database_subnet_id
  tags = merge(
    var.common_tags,
    {
      Component = "mysql"
    },
    {
      Name = "${local.ec2_name}-mysql"
    }
  )
}

output "mysql_private_ip" {
  value = module.mysql.private_ip
}

module "rabbitmq" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-rabbitmq"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
  subnet_id              = local.database_subnet_id
  tags = merge(
    var.common_tags,
    {
      Component = "rabbitmq"
    },
    {
      Name = "${local.ec2_name}-rabbitmq"
    }
  )
}

output "rabbitmq_private_ip" {
  value = module.rabbitmq.private_ip
}

module "catalogue" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-catalogue"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]
  subnet_id              = local.private_subnet_id
  tags = merge(
    var.common_tags,
    {
      Component = "catalogue"
    },
    {
      Name = "${local.ec2_name}-catalogue"
    }
  )
}

output "catalogue_private_ip" {
  value = module.catalogue.private_ip
}

module "user" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-user"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.user_sg_id.value]
  subnet_id              = local.private_subnet_id
  tags = merge(
    var.common_tags,
    {
      Component = "user"
    },
    {
      Name = "${local.ec2_name}-user"
    }
  )
}

output "user_private_ip" {
  value = module.user.private_ip
}

module "cart" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-cart"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.cart_sg_id.value]
  subnet_id              = local.private_subnet_id
  tags = merge(
    var.common_tags,
    {
      Component = "cart"
    },
    {
      Name = "${local.ec2_name}-cart"
    }
  )
}

output "cart_private_ip" {
  value = module.cart.private_ip
}

module "shipping" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-shipping"
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.shipping_sg_id.value]
  subnet_id              = local.private_subnet_id
  tags = merge(
    var.common_tags,
    {
      Component = "shipping"
    },
    {
      Name = "${local.ec2_name}-shipping"
    }
  )
}

output "shipping_private_ip" {
  value = module.shipping.private_ip
}

module "payment" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-payment"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.payment_sg_id.value]
  subnet_id              = local.private_subnet_id
  tags = merge(
    var.common_tags,
    {
      Component = "payment"
    },
    {
      Name = "${local.ec2_name}-payment"
    }
  )
}

output "payment_private_ip" {
  value = module.payment.private_ip
}

module "web" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-web"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.web_sg_id.value]
  subnet_id              = local.public_subnet_id
  tags = merge(
    var.common_tags,
    {
      Component = "web"
    },
    {
      Name = "${local.ec2_name}-web"
    }
  )
}

output "web_private_ip" {
  value = module.web.private_ip
}
output "web_public_ip" {
  value = module.web.public_ip
}

module "ansible" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-ansible"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  subnet_id              = data.aws_subnet.selected.id #  default VPC 1a subnet
  user_data = file("ec2-provision.sh")
  tags = merge(
    var.common_tags,
    {
      Component = "ansible"
    },
    {
      Name = "${local.ec2_name}-ansible"
    }
  )
}

output "ansible_private_ip" {
  value = module.ansible.private_ip
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name

  records = [
    {
      name    = "mongodb"
      type    = "A"
      ttl     = 1
      records = [
        module.ec2_instance.private_ip,
      ]
    },
    {
      name    = "redis"
      type    = "A"
      ttl     = 1
      records = [
        module.redis.private_ip,
      ]
    },
    {
      name    = "mysql"
      type    = "A"
      ttl     = 1
      records = [
        module.mysql.private_ip,
      ]
    },
    {
      name    = "rabbitmq"
      type    = "A"
      ttl     = 1
      records = [
        module.rabbitmq.private_ip,
      ]
    },
    {
      name    = "catalogue"
      type    = "A"
      ttl     = 1
      records = [
        module.catalogue.private_ip,
      ]
    },
    {
      name    = "user"
      type    = "A"
      ttl     = 1
      records = [
        module.user.private_ip,
      ]
    },
    {
      name    = "cart"
      type    = "A"
      ttl     = 1
      records = [
        module.cart.private_ip,
      ]
    },
    {
      name    = "shipping"
      type    = "A"
      ttl     = 1
      records = [
        module.shipping.private_ip,
      ]
    },
    {
      name    = "payment"
      type    = "A"
      ttl     = 1
      records = [
        module.payment.private_ip,
      ]
    },
    {
      name    = "web"
      type    = "A"
      ttl     = 1
      records = [
        module.web.private_ip,
      ]
    },
    {
      name    = ""
      type    = "A"
      ttl     = 1
      records = [
        module.web.public_ip,
      ]
    },
  ]
}
