
data "azurerm_resource_group" "test" {

  name = "dev"
}



variable "environment"

{
type = "string"
default = "dev"

}

variable "orgName"

{
type = "string"
default = "mrc"

}

variable "projectName"

{
type = "string"
default = "te"

}


variable "regionCode"

{
type = "string"
default = "usc"

}


variable "vnet"

{
type = "string"
default = "vnet"

}

variable "public"

{
type = "string"
default = "public"

}

variable "dmz"

{
type = "string"
default = "dmz"

}

variable "private"

{
type = "string"
default = "private"

}

variable "dbricks"

{
type = "string"
default = "dbricks"

}

variable "hdi"

{
type = "string"
default = "hdi"

}

locals {
  
  virtualnetworkname = "${var.orgName}-${var.regionCode}-${var.vnet}-${var.projectName}-${var.environment}"
  publicnsgname = "${var.orgName}-${var.regionCode}-${var.public}-${var.environment}"
  dmznsgname = "${var.orgName}-${var.regionCode}-${var.dmz}-${var.environment}"
  privatensgname = "${var.orgName}-${var.regionCode}-${var.private}-${var.environment}"
  dbricksnsgname = "${var.orgName}-${var.regionCode}-${var.dbricks}-${var.environment}"  
  hdinsgname = "${var.orgName}-${var.regionCode}-${var.hdi}-${var.environment}"
 
}



variable "publicSubnetName" {
    type = "string"
    default = "public-subnet"
}
variable "dmzSubnetName" {
    type = "string"
    default = "dmz-subnet"
}
variable "privateSubnetName" {
    type = "string"
    default = "private-subnet"
}
variable "hdiSubnetName" {
    type = "string"
    default = "hdi-subnet"
}

variable "dbricksPubSubnetName" {
    type = "string"
    default = "dbricks-public-subnet"
}

variable "dbricksPrivSubnetName" {
    type = "string"
    default = "dbricks-private-subnet"
}


