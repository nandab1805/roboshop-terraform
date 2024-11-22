module "vpn" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  envinorment = var.environment
  sg_description = "SG for vpn"
  vpc_id = data.aws_vpc.default.id
  sg_name = "vpn"
  # sg_ingress_rules = var.sg_ingress_rules
}
module "mongodb" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  envinorment = var.environment
  sg_description = "SG for mongodb"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "mongodb"
  # sg_ingress_rules = var.sg_ingress_rules
}
module "redis" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  envinorment = var.environment
  sg_description = "SG for redis"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "redis"
  # sg_ingress_rules = var.sg_ingress_rules
}
module "mysql" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  envinorment = var.environment
  sg_description = "SG for mysql"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "mysql"
  # sg_ingress_rules = var.sg_ingress_rules
}
module "rabbitmq" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  envinorment = var.environment
  sg_description = "SG for rabbitmq"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "rabbitmq"
  # sg_ingress_rules = var.sg_ingress_rules
}
module "catalogue" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  envinorment = var.environment
  sg_description = "SG for catalogue"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "catalogue"
  # sg_ingress_rules = var.sg_ingress_rules
}

module "user" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  envinorment = var.environment
  sg_description = "SG for user"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "user"
  # sg_ingress_rules = var.sg_ingress_rules
}
module "cart" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  envinorment = var.environment
  sg_description = "SG for cart"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "cart"
  # sg_ingress_rules = var.sg_ingress_rules
}
module "shipping" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  envinorment = var.environment
  sg_description = "SG for shipping"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "shipping"
  # sg_ingress_rules = var.sg_ingress_rules
}
module "payment" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  envinorment = var.environment
  sg_description = "SG for payment"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "payment"
  # sg_ingress_rules = var.sg_ingress_rules
}
module "web" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  envinorment = var.environment
  sg_description = "SG for web"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "web"
  # sg_ingress_rules = var.sg_ingress_rules
}

# module "dispatch" {
#   source = "../../terraform-aws-security-group"
#   project_name = var.project_name
#   envinorment = var.environment
#   sg_description = "SG for dispatch"
#   vpc_id = data.aws_ssm_parameter.vpc_id.value
#   sg_name = "dispatch"
#   # sg_ingress_rules = var.sg_ingress_rules
# }

#openvpn
resource "aws_security_group_rule" "vpn_home" {
  security_group_id = module.vpn.sg_id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = ["0.0.0.0/0"] #ideally your hme public ip address,but it frequently it changes
}


#mongodb accepting connections from catalogue instances
resource "aws_security_group_rule" "mongodb_catalogue" {
  source_security_group_id = module.catalogue.sg_id
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  source_security_group_id = module.user.sg_id
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "redis_user" {
  source_security_group_id = module.user.sg_id
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  source_security_group_id = module.cart.sg_id
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = module.redis.sg_id
}