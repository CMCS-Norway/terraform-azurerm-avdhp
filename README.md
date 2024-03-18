# Terraform AzureRM Azure Virtual Desktop Hostpool module
### This module deployes the following resources:
- 1 and only 1 Azure Virtual Desktop Hostpool
- Application groups, with workspacce attachment to the created AVD HP and 1 Entra ID group per application to provide access to remote desktop application for users. The ammount of application groups, etc. that will be deployed is decided in the "apps" key-value pair, see example!
- Storage account for FSLogix/profiles (optional)
- Private endpoint connection for FSLogix/Profiles storage account (optional)

### This module does NOT deploy the following resources:
- Virtual machine
- Probably something else ive forgotten to add

## Requirements
| | |
|----------|----------|
|Terraform | >= 1.5.0 |
| azurerm  | = 3.42.0 |
| azuread  | = 2.33.0 |


## Customizable module properties 

<details>
<summary>rdp_properties</summary>
description = RDP hostpool properties, also has a "ignore lifecycle change" tag on it, as scaling plans would not update the code..<br/><br/>
default = audiocapturemode:i:1;audiomode:i:0;redirectprinters:i:1;drivestoredirect:s:c\\:;autoreconnection enabled:i:1;enablerdsaadauth:i:1;use multimon:i:1;dynamic resolution:i:1;networkautodetect:i:1<br/><br/>
</details>

<details>
<summary>maximum_sessions_allowed</summary>
type= number<br/><br/>
description = Maximum hostpool sessions allowed on session hosts in host pool<br/><br/>
default = 10<br/><br/>
</details> 

<details>
<summary>type</summary>
description = What hostpool type to use in the hostpool<br/><br/>
default = Pooled<br/><br/>
</details> 

<details>
<summary>load_balancer_type</summary>
description = Acceptable values are: BreadthFirst, DepthFirst or Persistent<br/><br/>
default = DepthFirst<br/><br/>
</details>

<details>
<summary>security_enabled</summary>
description = Whether the group is a security group for controlling access to in-app resources. At least one of security_enabled or mail_enabled must be specified. A group can be security enabled and mail enabled<br/><br/>
default = true<br/><br/>
</details> 

<details>
<summary>start_vm_on_connect</summary>
type= bool<br/><br/>
description = Start the VM on connect if no available sessions<br/><br/>
default = true<br/><br/>
</details> 

<details>
<summary>location</summary>
description = Where will the host pool be deployed<br/><br/>
default = West Europe<br/><br/>
</details> 

<details>
<summary>root_name</summary>
description = Should be a unique identifier, short name for a customer, project or something<br/><br/>
default = csn<br/><br/>
</details>

<details>
<summary>subscription_id</summary>
description = Subscription ID where virtual machine sessions hosts are located, this should be it's own subscription ID in production environments<br/><br/>
default = null<br/><br/>
</details> 

<details>
<summary>apps</summary>
type= map(string)<br/><br/>
description = Name of apps that will be deployed in a key value pair for each app<br/><br/>
default =<br/><br/>
key = value
</details> 

<details>
<summary>hostpool</summary>
description = Name of hostpool that will be deployed<br/><br/>
default = prod-01<br/><br/>
</details> 

<details>
<summary>validate_environment</summary>
type= bool<br/><br/>
description = Wether to validate environment or not<br/><br/>
default = false <br/><br/>
</details>

<details>
<summary>create_scaling_plan</summary>
type= bool<br/><br/>
description = true or false if you want to create scaling plan and attach to the host pool<br/><br/>
default = false <br/><br/>
</details>

<details>
<summary>avd_displayname</summary>
description = Display name of Azure Virtual Desktop Enterprise application in Entra ID<br/><br/>
default = Azure Virtual Desktop <br/><br/>
</details>
