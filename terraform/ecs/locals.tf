locals {
  name_prefix = "goldenowl-devops"

  selected_availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]

  public_subnets = {
    for index, availability_zone in local.selected_availability_zones :
    availability_zone => var.public_subnet_cidrs[index]
  }
}
