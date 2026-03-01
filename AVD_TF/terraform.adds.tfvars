# ============================================================================
# AVD Deployment - ADDS (Active Directory Domain Services) Identity Provider
# ============================================================================
# Use case: Hybrid environments with on-premises Active Directory
# Authentication: Windows Server Active Directory Domain Services
# Domain join: ENABLED (VMs join to on-premises AD domain)
# Requirements: Network connectivity to domain controllers (VPN/ExpressRoute)
# ============================================================================

deployment_prefix             = "ETF"
deployment_environment        = "Test"

# ============================================================================
# IDENTITY CONFIGURATION - ADDS (On-Premises Active Directory)
# ============================================================================
avd_identity_service_provider = "ADDS"

# Domain settings: REQUIRED - Replace with your actual domain details
identity_domain_name           = "contoso.com"                # CHANGE: Your AD domain FQDN
avd_domain_join_user_name      = "domainadmin@contoso.com"    # CHANGE: Domain join account UPN
avd_domain_join_user_password  = "YourSecurePassword123!"     # CHANGE: Domain join account password
avd_ou_path                    = "OU=AVD,OU=Computers,DC=contoso,DC=com"  # OPTIONAL: Target OU for computer objects

# ============================================================================
# LOCATION SETTINGS
# ============================================================================
avd_session_host_location     = "East US"
avd_management_plane_location = "East US"
management_plane_location_short = "eus"
session_host_location_short     = "eus"
scaling_plan_time_zone          = "UTC"

# ============================================================================
# SESSION HOST CREDENTIALS
# ============================================================================
avd_vm_local_user_name        = "avdadmin"
avd_vm_local_user_password    = "ChangeMe!"

# ============================================================================
# HOST POOL CONFIGURATION
# ============================================================================
avd_host_pool_type            = "Pooled"
host_pool_preferred_app_group_type = "Desktop"
avd_host_pool_load_balancer_type   = "DepthFirst"

# ============================================================================
# SESSION HOST DEPLOYMENT
# ============================================================================
avd_deploy_session_hosts      = true
avd_deploy_session_hosts_count = 1
avd_session_host_count_index  = 1
avd_session_hosts_size        = "Standard_D2als_v6"

# ============================================================================
# NETWORKING (Using Terraform-created VNET)
# ============================================================================
# IMPORTANT: For ADDS, ensure VNet has connectivity to domain controllers
# via VPN Gateway, ExpressRoute, or Site-to-Site VPN
existing_vnet_avd_subnet_resource_id = ""
existing_vnet_private_endpoint_subnet_resource_id = ""
vnet_resource_group           = "rg-network"
vnet_name                     = "vnet-avd"
subnet_name                   = "snet-avd"

# ============================================================================
# STORAGE CONFIGURATION
# ============================================================================
create_avd_fslogix_deployment = true
create_app_attach_deployment  = false

# ============================================================================
# AZURE SUBSCRIPTION & TENANT
# ============================================================================
subscription_id = "bd67233d-38af-45db-a98e-a10a2b443d8d"
tenant_id       = "d3edc3c2-c1ad-469e-a53a-7dac46272775"

# ============================================================================
# TAGS
# ============================================================================
create_resource_tags          = false

tags = {
  Environment = "Test"
  IdentityProvider = "ADDS"
}
