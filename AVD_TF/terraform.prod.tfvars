deployment_prefix             = "ETF"
deployment_environment        = "Prod"

avd_session_host_location     = "East US"
avd_management_plane_location = "East US"
management_plane_location_short = "eus"
session_host_location_short     = "eus"
scaling_plan_time_zone          = "UTC"

avd_vm_local_user_name        = "avdadmin"
avd_vm_local_user_password    = "ChangeMe!"
avd_identity_service_provider = "EntraID"

avd_host_pool_type            = "Pooled"
host_pool_preferred_app_group_type = "Desktop"
avd_host_pool_load_balancer_type   = "DepthFirst"

avd_deploy_session_hosts      = true
avd_deploy_session_hosts_count = 1
avd_session_host_count_index  = 1
avd_session_hosts_size        = "Standard_D2als_v6"

create_avd_vnet               = true
existing_vnet_avd_subnet_resource_id = ""
existing_vnet_private_endpoint_subnet_resource_id = ""

vnet_resource_group           = "rg-network"
vnet_name                     = "vnet-avd"
subnet_name                   = "snet-avd"

create_avd_fslogix_deployment = true
create_app_attach_deployment  = false

create_resource_tags          = false

subscription_id = "bd67233d-38af-45db-a98e-a10a2b443d8d"
tenant_id       = "d3edc3c2-c1ad-469e-a53a-7dac46272775"

tags = {
  Environment = "Prod"
}
