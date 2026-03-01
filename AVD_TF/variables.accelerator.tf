variable "deployment_prefix" {
  description = "Deployment prefix used for naming (default ETF1)."
  type        = string
  default     = "ETF"
}

variable "deployment_environment" {
  description = "Deployment environment (Dev, Test, Prod)."
  type        = string
  default     = "Test"
}

variable "use_single_resource_group" {
  description = "Create a single resource group and place all resources in it."
  type        = bool
  default     = false
}

variable "single_resource_group_name" {
  description = "Custom name for the single resource group (optional)."
  type        = string
  default     = ""
}

variable "disk_encryption_key_expiration_in_days" {
  description = "Expiration days for disk encryption key."
  type        = number
  default     = 60
}

variable "avd_session_host_location" {
  description = "Location where to deploy compute services."
  type        = string
  default     = null
}

variable "avd_management_plane_location" {
  description = "Location where to deploy AVD management plane."
  type        = string
  default     = null
}

variable "avd_workload_subscription_id" {
  description = "AVD workload subscription ID."
  type        = string
  default     = null
}

variable "avd_service_principal_object_id" {
  description = "Azure Virtual Desktop Enterprise Application object ID."
  type        = string
  default     = ""
}

variable "avd_arm_service_principal_object_id" {
  description = "Azure Virtual Desktop ARM Provider enterprise app object ID."
  type        = string
  default     = ""
}

variable "avd_vm_local_user_name" {
  description = "AVD session host local username."
  type        = string
  default     = null
}

variable "avd_vm_local_user_password" {
  description = "AVD session host local password."
  type        = string
  sensitive   = true
  default     = null
}

variable "avd_identity_service_provider" {
  description = "Identity provider for AVD (ADDS, EntraDS, EntraID, EntraIDKerberos)."
  type        = string
  default     = "ADDS"
}

variable "create_intune_enrollment" {
  description = "Enroll session hosts on Intune."
  type        = bool
  default     = false
}

variable "avd_security_groups" {
  description = "Identity group objects to grant RBAC and NTFS permissions."
  type = list(object({
    object_id    = string
    display_name = string
  }))
  default = []
}

variable "identity_domain_name" {
  description = "FQDN of on-premises AD domain for FSLogix configuration."
  type        = string
  default     = "none"
}

variable "identity_domain_guid" {
  description = "GUID of on-premises AD domain for FSLogix configuration."
  type        = string
  default     = ""
}

variable "avd_domain_join_user_name" {
  description = "Domain join user principal name."
  type        = string
  default     = "none"
}

variable "avd_domain_join_user_password" {
  description = "Domain join user password."
  type        = string
  sensitive   = true
  default     = "none"
}

variable "avd_ou_path" {
  description = "OU path for domain join."
  type        = string
  default     = ""
}

variable "avd_host_pool_type" {
  description = "Host pool type (Personal or Pooled)."
  type        = string
  default     = "Pooled"
}

variable "host_pool_preferred_app_group_type" {
  description = "Preferred app group type (Desktop or RemoteApp)."
  type        = string
  default     = "Desktop"
}

variable "host_pool_public_network_access" {
  description = "Public network access for host pool."
  type        = string
  default     = "Enabled"
}

variable "workspace_public_network_access" {
  description = "Public network access for workspace."
  type        = string
  default     = "Enabled"
}

variable "avd_personal_assign_type" {
  description = "Personal host pool assignment type (Automatic or Direct)."
  type        = string
  default     = "Automatic"
}

variable "avd_host_pool_load_balancer_type" {
  description = "Host pool load balancer type (DepthFirst or DepthFirst)."
  type        = string
  default     = "DepthFirst"
}

variable "host_pool_max_sessions" {
  description = "Max number of sessions per host."
  type        = number
  default     = 8
}

variable "avd_start_vm_on_connect" {
  description = "Start VM on connect."
  type        = bool
  default     = true
}

variable "avd_host_pool_rdp_properties" {
  description = "Custom RDP properties string."
  type        = string
  default     = "audiocapturemode:i:1;audiomode:i:0;drivestoredirect:s:;redirectclipboard:i:1;redirectcomports:i:1;redirectprinters:i:1;redirectsmartcards:i:1;screen mode id:i:2"
}

variable "registration_expiration" {
  description = "Host pool registration token expiration timestamp (UTC)."
  type        = string
  default     = null
}

variable "avd_deploy_scaling_plan" {
  description = "Deploy scaling plan."
  type        = bool
  default     = true
}

variable "scaling_plan_time_zone" {
  description = "Scaling plan time zone."
  type        = string
  default     = "UTC"
}

variable "create_avd_vnet" {
  description = "Create new virtual network for AVD."
  type        = bool
  default     = true
}

variable "existing_vnet_avd_subnet_resource_id" {
  description = "Existing subnet resource ID for AVD session hosts."
  type        = string
  default     = ""
}

variable "existing_vnet_private_endpoint_subnet_resource_id" {
  description = "Existing subnet resource ID for private endpoints."
  type        = string
  default     = ""
}

variable "existing_hub_vnet_resource_id" {
  description = "Existing hub virtual network resource ID for peering."
  type        = string
  default     = ""
}

variable "avd_vnetwork_address_prefixes" {
  description = "VNET address prefix."
  type        = string
  default     = "10.10.0.0/16"
}

variable "vnetwork_avd_subnet_address_prefix" {
  description = "AVD subnet address prefix."
  type        = string
  default     = "10.10.1.0/24"
}

variable "vnetwork_private_endpoint_subnet_address_prefix" {
  description = "Private endpoint subnet address prefix."
  type        = string
  default     = "10.10.2.0/27"
}

variable "vnet_resource_group" {
  description = "Resource group containing the existing virtual network."
  type        = string
  default     = ""
}

variable "vnet_name" {
  description = "Name of the existing virtual network."
  type        = string
  default     = ""
}

variable "subnet_name" {
  description = "Name of the existing subnet for AVD session hosts."
  type        = string
  default     = ""
}

variable "custom_dns_ips" {
  description = "Custom DNS server IPs (comma-separated)."
  type        = string
  default     = ""
}

variable "deploy_ddos_network_protection" {
  description = "Deploy DDoS Network Protection for the virtual network."
  type        = bool
  default     = false
}

variable "deploy_private_endpoint_keyvault_storage" {
  description = "Deploy private endpoints for Key Vault and Storage."
  type        = bool
  default     = false
}

variable "deploy_avd_private_link_service" {
  description = "Deploy AVD private link service."
  type        = bool
  default     = false
}

variable "create_private_dns_zones" {
  description = "Create private DNS zones for private endpoints."
  type        = bool
  default     = true
}

variable "avd_vnet_private_dns_zone_connection_resource_id" {
  description = "Private DNS zone resource ID for connection."
  type        = string
  default     = ""
}

variable "avd_vnet_private_dns_zone_discovery_resource_id" {
  description = "Private DNS zone resource ID for discovery."
  type        = string
  default     = ""
}

variable "avd_vnet_private_dns_zone_files_id" {
  description = "Private DNS zone resource ID for Azure Files."
  type        = string
  default     = ""
}

variable "avd_vnet_private_dns_zone_keyvault_id" {
  description = "Private DNS zone resource ID for Key Vault."
  type        = string
  default     = ""
}

variable "vnetwork_gateway_on_hub" {
  description = "Indicates if hub VNET has a gateway."
  type        = bool
  default     = false
}

variable "create_avd_fslogix_deployment" {
  description = "Deploy FSLogix setup."
  type        = bool
  default     = true
}

variable "storage_public_network_access_enabled" {
  description = "Allow public network access to storage accounts for provisioning."
  type        = bool
  default     = true
}

variable "create_app_attach_deployment" {
  description = "Deploy App Attach setup."
  type        = bool
  default     = false
}

variable "fslogix_file_share_quota_size" {
  description = "FSLogix file share quota size (TB)."
  type        = number
  default     = 1
}

variable "app_attach_file_share_quota_size" {
  description = "App Attach file share quota size (TB)."
  type        = number
  default     = 1
}

variable "avd_deploy_session_hosts" {
  description = "Deploy new session hosts."
  type        = bool
  default     = true
}

variable "enable_avd_registration" {
  description = "Enable AVD registration extension for session hosts."
  type        = bool
  default     = true
}

variable "deploy_gpu_policies" {
  description = "Deploy GPU extension policies."
  type        = bool
  default     = false
}

variable "avd_deploy_monitoring" {
  description = "Deploy AVD monitoring resources."
  type        = bool
  default     = false
}

variable "deploy_ala_workspace" {
  description = "Deploy Azure Log Analytics workspace."
  type        = bool
  default     = true
}

variable "deploy_custom_policy_monitoring" {
  description = "Deploy custom policy for diagnostic settings."
  type        = bool
  default     = false
}

variable "avd_ala_workspace_data_retention" {
  description = "Log Analytics data retention in days."
  type        = number
  default     = 90
}

variable "ala_existing_workspace_resource_id" {
  description = "Existing Log Analytics workspace resource ID."
  type        = string
  default     = ""
}

variable "avd_deploy_session_hosts_count" {
  description = "Quantity of session hosts to deploy."
  type        = number
  default     = 1
}

variable "avd_session_host_count_index" {
  description = "Starting index for session host naming."
  type        = number
  default     = 1
}

variable "availability" {
  description = "Availability mode (None, AvailabilityZones)."
  type        = string
  default     = "None"
}

variable "availability_zones" {
  description = "Availability zones to use."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "zone_redundant_storage" {
  description = "Use ZRS instead of LRS for storage."
  type        = bool
  default     = false
}

variable "fslogix_storage_performance" {
  description = "Storage performance tier for FSLogix."
  type        = string
  default     = "Premium"
}

variable "app_attach_storage_performance" {
  description = "Storage performance tier for App Attach."
  type        = string
  default     = "Premium"
}

variable "disk_zero_trust" {
  description = "Enable zero trust configuration on session host disks."
  type        = bool
  default     = false
}

variable "avd_session_hosts_size" {
  description = "Session host VM size."
  type        = string
  default     = "Standard_D2ps_v6"
}

variable "avd_session_host_disk_type" {
  description = "OS disk type for session host."
  type        = string
  default     = "Premium_LRS"
}

variable "custom_os_disk_size_gb" {
  description = "Custom OS disk size in GB."
  type        = number
  default     = 0
}

variable "enable_accelerated_networking" {
  description = "Enable accelerated networking."
  type        = bool
  default     = true
}

variable "security_type" {
  description = "VM security type (Standard or TrustedLaunch)."
  type        = string
  default     = "TrustedLaunch"
}

variable "secure_boot_enabled" {
  description = "Enable secure boot."
  type        = bool
  default     = true
}

variable "vtpm_enabled" {
  description = "Enable vTPM."
  type        = bool
  default     = true
}

variable "use_shared_image" {
  description = "Use Azure Compute Gallery image."
  type        = bool
  default     = false
}

variable "mp_image_offer" {
  description = "Marketplace image offer."
  type        = string
  default     = "windows-11"
}

variable "mp_image_sku" {
  description = "Marketplace image SKU."
  type        = string
  default     = "win11-24h2-avd"
}

variable "avd_custom_image_definition_id" {
  description = "Custom image definition resource ID."
  type        = string
  default     = ""
}

variable "management_vm_os_image" {
  description = "Management VM image SKU."
  type        = string
  default     = "winServer_2022_Datacenter_smalldisk_g2"
}

variable "storage_ou_path" {
  description = "OU path for storage account computer objects."
  type        = string
  default     = ""
}

variable "avd_use_custom_naming" {
  description = "Use custom naming for AVD resources."
  type        = bool
  default     = false
}

variable "avd_service_objects_rg_custom_name" {
  description = "Custom name for service objects resource group."
  type        = string
  default     = "rg-avd-app1-dev-use2-service-objects"
}

variable "avd_network_objects_rg_custom_name" {
  description = "Custom name for network resource group."
  type        = string
  default     = "rg-avd-app1-dev-use2-network"
}

variable "avd_compute_objects_rg_custom_name" {
  description = "Custom name for compute resource group."
  type        = string
  default     = "rg-avd-app1-dev-use2-pool-compute"
}

variable "avd_storage_objects_rg_custom_name" {
  description = "Custom name for storage resource group."
  type        = string
  default     = "rg-avd-app1-dev-use2-storage"
}

variable "avd_monitoring_rg_custom_name" {
  description = "Custom name for monitoring resource group."
  type        = string
  default     = "rg-avd-dev-use2-monitoring"
}

variable "avd_vnetwork_custom_name" {
  description = "Custom name for AVD VNET."
  type        = string
  default     = "vnet-app1-dev-use2-001"
}

variable "avd_ala_workspace_custom_name" {
  description = "Custom name for AVD Log Analytics workspace."
  type        = string
  default     = "log-avd-app1-dev-use2"
}

variable "avd_vnetwork_subnet_custom_name" {
  description = "Custom name for AVD subnet."
  type        = string
  default     = "snet-avd-app1-dev-use2-001"
}

variable "private_endpoint_vnetwork_subnet_custom_name" {
  description = "Custom name for private endpoint subnet."
  type        = string
  default     = "snet-pe-app1-dev-use2-001"
}

variable "avd_network_security_group_custom_name" {
  description = "Custom name for AVD NSG."
  type        = string
  default     = "nsg-avd-app1-dev-use2-001"
}

variable "private_endpoint_network_security_group_custom_name" {
  description = "Custom name for private endpoint NSG."
  type        = string
  default     = "nsg-pe-app1-dev-use2-001"
}

variable "avd_route_table_custom_name" {
  description = "Custom name for AVD route table."
  type        = string
  default     = "route-avd-app1-dev-use2-001"
}

variable "private_endpoint_route_table_custom_name" {
  description = "Custom name for private endpoint route table."
  type        = string
  default     = "route-pe-app1-dev-use2-001"
}

variable "avd_application_security_group_custom_name" {
  description = "Custom name for AVD ASG."
  type        = string
  default     = "asg-app1-dev-use2-001"
}

variable "avd_workspace_custom_name" {
  description = "Custom name for AVD workspace."
  type        = string
  default     = "vdws-app1-dev-use2-001"
}

variable "avd_workspace_custom_friendly_name" {
  description = "Custom friendly name for AVD workspace."
  type        = string
  default     = "App1 - Dev - East US 2 - 001"
}

variable "avd_hostpool_custom_name" {
  description = "Custom name for AVD host pool."
  type        = string
  default     = "vdpool-app1-dev-use2-001"
}

variable "avd_hostpool_custom_friendly_name" {
  description = "Custom friendly name for AVD host pool."
  type        = string
  default     = "App1 - Dev - East US 2 - 001"
}

variable "avd_scaling_plan_custom_name" {
  description = "Custom name for AVD scaling plan."
  type        = string
  default     = "vdscaling-app1-dev-use2-001"
}

variable "avd_application_group_custom_name" {
  description = "Custom name for AVD application group."
  type        = string
  default     = "vdag-desktop-app1-dev-use2-001"
}

variable "avd_application_group_custom_friendly_name" {
  description = "Custom friendly name for AVD application group."
  type        = string
  default     = "Desktops - App1 - Dev - East US 2 - 001"
}

variable "avd_session_host_custom_name_prefix" {
  description = "Custom name prefix for session hosts."
  type        = string
  default     = "vmapp1duse2"
}

variable "storage_account_prefix_custom_name" {
  description = "Custom prefix for storage accounts (2 chars)."
  type        = string
  default     = "st"
}

variable "fslogix_file_share_custom_name" {
  description = "Custom name for FSLogix file share."
  type        = string
  default     = "fslogix-pc-app1-dev-use2-001"
}

variable "app_attach_file_share_custom_name" {
  description = "Custom name for App Attach file share."
  type        = string
  default     = "appa-app1-dev-use2-001"
}

variable "avd_wrkl_kv_prefix_custom_name" {
  description = "Custom prefix for workload Key Vault."
  type        = string
  default     = "kv-sec"
}

variable "zt_disk_encryption_set_custom_name_prefix" {
  description = "Custom prefix for disk encryption set."
  type        = string
  default     = "des-zt"
}

variable "zt_kv_prefix_custom_name" {
  description = "Custom prefix for zero trust Key Vault."
  type        = string
  default     = "kv-key"
}

variable "create_resource_tags" {
  description = "Apply workload tags to resources and resource groups."
  type        = bool
  default     = false
}

variable "workload_name_tag" {
  description = "Workload name tag value."
  type        = string
  default     = "Contoso-Workload"
}

variable "workload_type_tag" {
  description = "Workload type tag value."
  type        = string
  default     = "Light"
}

variable "data_classification_tag" {
  description = "Data classification tag value."
  type        = string
  default     = "Non-business"
}

variable "department_tag" {
  description = "Department tag value."
  type        = string
  default     = "Contoso-AVD"
}

variable "workload_criticality_tag" {
  description = "Criticality tag value."
  type        = string
  default     = "Low"
}

variable "workload_criticality_custom_value_tag" {
  description = "Custom criticality tag value."
  type        = string
  default     = "Contoso-Critical"
}

variable "application_name_tag" {
  description = "Application name tag value."
  type        = string
  default     = "Contoso-App"
}

variable "workload_sla_tag" {
  description = "Workload SLA tag value."
  type        = string
  default     = "Contoso-SLA"
}

variable "ops_team_tag" {
  description = "Ops team tag value."
  type        = string
  default     = "workload-admins@Contoso.com"
}

variable "owner_tag" {
  description = "Owner tag value."
  type        = string
  default     = "workload-owner@Contoso.com"
}

variable "cost_center_tag" {
  description = "Cost center tag value."
  type        = string
  default     = "Contoso-CC"
}

variable "time" {
  description = "Timestamp used for naming and tags."
  type        = string
  default     = null
}

variable "enable_telemetry" {
  description = "Enable usage and telemetry feedback."
  type        = bool
  default     = true
}

variable "enable_kv_purge_protection" {
  description = "Enable purge protection for Key Vaults."
  type        = bool
  default     = true
}

variable "key_vault_public_network_access_enabled" {
  description = "Allow public network access to Key Vaults for provisioning."
  type        = bool
  default     = true
}

variable "deploy_anti_malware_ext" {
  description = "Deploy anti-malware extension on session hosts."
  type        = bool
  default     = true
}

variable "custom_static_routes" {
  description = "Additional static routes to add to route tables."
  type        = list(map(string))
  default     = []
}

variable "deploy_defender" {
  description = "Enable Microsoft Defender on the subscription."
  type        = bool
  default     = false
}

variable "enable_def_for_servers" {
  description = "Enable Microsoft Defender for servers."
  type        = bool
  default     = true
}

variable "enable_def_for_storage" {
  description = "Enable Microsoft Defender for storage."
  type        = bool
  default     = true
}

variable "enable_def_for_keyvault" {
  description = "Enable Microsoft Defender for Key Vault."
  type        = bool
  default     = true
}

variable "enable_def_for_arm" {
  description = "Enable Microsoft Defender for ARM."
  type        = bool
  default     = true
}
