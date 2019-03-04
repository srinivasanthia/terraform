


variable "sourceiprange-hdisslrule" {
    type = "list"
    default = ["168.61.49.99","23.99.5.239","168.61.48.131","138.91.141.162","13.67.223.215","40.86.83.253"]
}

variable "sourceiprange-dmzsshrule" {
    type = "list"
    default = ["38.88.48.82/32","34.232.196.25/32","198.72.78.0/24"]
}

variable "controlPlaneIp" {
    type = "map"

default = {
    "australiacentral" = "13.70.105.50/32",
      "australiacentral2"= "13.70.105.50/32",
      "australiaeast"= "13.70.105.50/32",
      "australiasoutheast"= "13.70.105.50/32",
      "canadacentral"= "40.85.223.25/32",
      "canadaeast"= "40.85.223.25/32",
      "centralindia"= "104.211.101.14/32",
      "centralus"= "23.101.152.95/32",
      "eastasia"= "52.187.0.85/32",
      "eastus"= "23.101.152.95/32",
      "eastus2"= "23.101.152.95/32",
      "eastus2euap"= "23.101.152.95/32",
      "japaneast"= "13.78.19.235/32",
      "japanwest"= "13.78.19.235/32",
      "northcentralus"= "23.101.152.95/32",
      "northeurope"= "23.100.0.135/32",
      "southcentralus"= "40.83.178.242/32",
      "southeastasia"= "52.187.0.85/32",
      "southindia"= "104.211.101.14/32",
      "uksouth"= "51.140.203.27/32",
      "ukwest"= "51.140.203.27/32",
      "westcentralus"= "40.83.178.242/32",
      "westeurope"= "23.100.0.135/32",
      "westindia"= "104.211.101.14/32",
      "westus"= "40.83.178.242/32",
      "westus2"= "40.83.178.242/32"

}
}

variable "webappIp" {
    type = "map"

default = {
    "australiacentral"= "13.75.218.172/32",
      "australiacentral2"= "13.75.218.172/32",
      "australiaeast"= "13.75.218.172/32",
      "australiasoutheast"= "13.75.218.172/32",
      "canadacentral"= "13.71.184.74/32",
      "canadaeast"= "13.71.184.74/32",
      "centralindia"= "104.211.89.81/32",
      "centralus"= "40.70.58.221/32",
      "eastasia"= "52.187.145.107/32",
      "eastus"= "40.70.58.221/32",
      "eastus2"= "40.70.58.221/32",
      "eastus2euap"= "40.70.58.221/32",
      "japaneast"= "52.246.160.72/32",
      "japanwest"= "52.246.160.72/32",
      "northcentralus"= "40.70.58.221/32",
      "northeurope"= "52.232.19.246/32",
      "southcentralus"= "40.118.174.12/32",
      "southeastasia"= "52.187.145.107/32",
      "southindia"= "104.211.89.81/32",
      "uksouth"= "51.140.204.4/32",
      "ukwest"= "51.140.204.4/32",
      "westcentralus"= "40.118.174.12/32",
      "westeurope"= "52.232.19.246/32",
      "westindia"= "104.211.89.81/32",
      "westus"= "40.118.174.12/32",
      "westus2"= "40.118.174.12/32"

}
}



resource "azurerm_network_security_group" "publicNSGName_nsg" {
    name                = "${local.publicnsgname}"
    location            = "${data.azurerm_resource_group.test.location}"
    resource_group_name = "${data.azurerm_resource_group.test.name}"
    
}

resource "azurerm_network_security_group" "dmzNSGName_nsg" {
    name                = "${local.dmznsgname}"
    location            = "${data.azurerm_resource_group.test.location}"
    resource_group_name = "${data.azurerm_resource_group.test.name}"
    
}


resource "azurerm_network_security_group" "privateSubnetName_nsg" {
    name                = "${local.privatensgname}"
    location            = "${data.azurerm_resource_group.test.location}"
    resource_group_name = "${data.azurerm_resource_group.test.name}"
    
}

resource "azurerm_network_security_group" "hdiSubnetName_nsg" {
    name                = "${local.hdinsgname}"
    location            = "${data.azurerm_resource_group.test.location}"
    resource_group_name = "${data.azurerm_resource_group.test.name}"
    
}


resource "azurerm_network_security_group" "dbricks_nsg" {
    name                = "${local.dbricksnsgname}"
    location            = "${data.azurerm_resource_group.test.location}"
    resource_group_name = "${data.azurerm_resource_group.test.name}"
    
}





resource "azurerm_virtual_network" "virtualnetwork" {

  name                = "${local.virtualnetworkname}"
  location            = "${data.azurerm_resource_group.test.location}"
  resource_group_name = "${data.azurerm_resource_group.test.name}"
  address_space       = ["10.0.0.0/16"]
}


resource "azurerm_subnet" "test_public" {
  name                 = "${var.publicSubnetName}"
  resource_group_name  = "${data.azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.virtualnetwork.name}"
  network_security_group_id = "${azurerm_network_security_group.publicNSGName_nsg.id}"  
  address_prefix       = "10.0.6.0/24"
}

resource "azurerm_subnet" "test_dmz" {
  name                 = "${var.dmzSubnetName}"
  resource_group_name  = "${data.azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.virtualnetwork.name}"
  network_security_group_id = "${azurerm_network_security_group.dmzNSGName_nsg.id}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_subnet" "test_private" {
  name                 = "${var.privateSubnetName}"
  resource_group_name  = "${data.azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.virtualnetwork.name}"
  network_security_group_id = "${azurerm_network_security_group.privateSubnetName_nsg.id}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_subnet" "test_hdi" {
  name                 = "${var.hdiSubnetName}"
  resource_group_name  = "${data.azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.virtualnetwork.name}"
  network_security_group_id = "${azurerm_network_security_group.hdiSubnetName_nsg.id}"
  address_prefix       = "10.0.3.0/24"
}

resource "azurerm_subnet" "test_dpub" {
  name                 = "${var.dbricksPubSubnetName}"
  resource_group_name  = "${data.azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.virtualnetwork.name}"
  network_security_group_id = "${azurerm_network_security_group.dbricks_nsg.id}"
  address_prefix       = "10.0.4.0/24"
}

resource "azurerm_subnet" "test_dpri" {
  name                 = "${var.dbricksPrivSubnetName}"
  resource_group_name  = "${data.azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.virtualnetwork.name}"
  network_security_group_id = "${azurerm_network_security_group.dbricks_nsg.id}"
  address_prefix       = "10.0.5.0/24"
}


resource "azurerm_network_security_rule" "publicnsgrule" {
        name                       = "allow-public-ssl"
        priority                   = 1000
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.publicNSGName_nsg.name}"
    }

resource "azurerm_network_security_rule" "dmznsgrule" {
        name                       = "allow-dmz-ssl"
        priority                   = 1000
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "38.88.48.82/32"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dmzNSGName_nsg.name}"
    }

resource "azurerm_network_security_rule" "dmzwebrule" {
        name                       = "allow-dmz-web"
        priority                   = 1050
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "38.88.48.82/32"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dmzNSGName_nsg.name}"
    }

resource "azurerm_network_security_rule" "dmzuirule" {
        name                       = "allow-dmz-ui"
        priority                   = 1100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dmzNSGName_nsg.name}"
    }

resource "azurerm_network_security_rule" "dmzrdprule" {
        name                       = "allow-dmz-rdp"
        priority                   = 1200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "38.88.48.82/32"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dmzNSGName_nsg.name}"
    }



resource "azurerm_network_security_rule" "dmzsshrule" {
        name                       = "allow-dmz-ssh"
        priority                   = 1300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefixes      = "${var.sourceiprange-dmzsshrule}"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dmzNSGName_nsg.name}"
    }

resource "azurerm_network_security_rule" "privaterule" {
        name                       = "allow-public-subnet"
        priority                   = 1000
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.0.0/24"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.privateSubnetName_nsg.name}"
    }


resource "azurerm_network_security_rule" "dmzallowrule" {
        name                       = "allow-dmz-subnet"
        priority                   = 1100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.1.0/24"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.privateSubnetName_nsg.name}"
    }




resource "azurerm_network_security_rule" "hdisslrule" {
        name                       = "allow-hdi"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefixes     = "${var.sourceiprange-hdisslrule}"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.hdiSubnetName_nsg.name}"
    }

resource "azurerm_network_security_rule" "hdisslrule2" {
        name                       = "allow-azure-resolver"
        priority                   = 200
        description                = "Allow access from Azure's recursive resolver"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "443"
        destination_port_range     = "*"
        source_address_prefix      = "168.63.129.16"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.hdiSubnetName_nsg.name}"
    }


resource "azurerm_network_security_rule" "hdiallrule" {
        name                       = "allow-public-subnet"
        priority                   = 1000
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.0.0/24"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.hdiSubnetName_nsg.name}"
    }

resource "azurerm_network_security_rule" "hdidmzallrule" {
        name                       = "allow-dmz-subnett"
        priority                   = 1100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.1.0/24"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.hdiSubnetName_nsg.name}"
    }



resource "azurerm_network_security_rule" "hdimrcrule" {
        name                       = "allow-mrc-ssl"
        priority                   = 1400
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "443"
        destination_port_range     = "*"
        source_address_prefix      = "198.72.78.0/24"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.hdiSubnetName_nsg.name}"
    }


resource "azurerm_network_security_rule" "databricks-Rule1" {
        name                       = "databricks-worker-to-worker"
        priority                   = 200
        description                = "Required for worker nodes communication within a cluster."
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dbricks_nsg.name}"
    }

resource "azurerm_network_security_rule" "databricks-Rule2" {
        name                       = "databricks-control-plane-ssh"
        priority                   = 1100
        description                = "Required for Databricks control plane management of worker nodes."
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "${var.controlPlaneIp[data.azurerm_resource_group.test.location]}"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dbricks_nsg.name}"
    }



resource "azurerm_network_security_rule" "databricks-Rule3" {
        name                       = "databricks-control-plane-worker-proxy"
        priority                   = 110
        description                = "Required for Databricks control plane communication with worker nodes.."
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_range     = "5557"
        source_address_prefix      = "${var.controlPlaneIp[data.azurerm_resource_group.test.location]}"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dbricks_nsg.name}"
    }



resource "azurerm_network_security_rule" "databricks-Rule4" {
        name                       = "databricks-worker-to-webapp"
        priority                   = 100
        description                = "Required for workers communication with Databricks Webapp."
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "${var.webappIp[data.azurerm_resource_group.test.location]}"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dbricks_nsg.name}"
    }


resource "azurerm_network_security_rule" "databricks-Rule5" {
        name                       = "databricks-worker-to-sql"
        priority                   = 110
        description                = "Required for workers communication with Azure SQL services."
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "sql"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dbricks_nsg.name}"
    }

resource "azurerm_network_security_rule" "databricks-Rule6" {
        name                       = "databricks-worker-to-storage"
        priority                   = 120
        description                = "Required for workers communication with Azure Storage services."
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "Storage"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dbricks_nsg.name}"
    }


resource "azurerm_network_security_rule" "databricks-Rule7" {
        name                       = "databricks-worker-to-worker-outbound"
        priority                   = 130
        description                = "Required for worker nodes communication within a cluster."
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dbricks_nsg.name}"
    }


resource "azurerm_network_security_rule" "databricks-Rule8" {
        name                       = "databricks-worker-to-any"
        priority                   = 140
        description                = "Required for worker nodes communication with any destination."
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        resource_group_name         = "${data.azurerm_resource_group.test.name}"
        network_security_group_name = "${azurerm_network_security_group.dbricks_nsg.name}"
    }

































