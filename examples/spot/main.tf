module "bastion_host" {
  source = "../../"

  egress_open_tcp_ports = [3306, 5432]

  iam_user_arns = [module.bastion_user.iam_user_arn]

  instance = {
    type              = "t3.nano"
    desired_capacity  = 2
    root_volume_size  = 8
    enable_monitoring = false

    enable_spot = true

    profile_name = "AmazonSSMRoleForInstancesQuickSetup"
  }

  instances_distribution = {
    on_demand_base_capacity                  = 1
    on_demand_percentage_above_base_capacity = 0
    spot_allocation_strategy                 = "lowest-price"
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  resource_names = {
    prefix    = local.resource_prefix
    separator = "-"
  }
}

module "bastion_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.11.2"

  name = "${local.resource_prefix}-bastion"

  password_reset_required       = false
  create_iam_user_login_profile = false
  force_destroy                 = true
}
