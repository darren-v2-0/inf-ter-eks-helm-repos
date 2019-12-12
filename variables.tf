#READ ONLY ACCESS GRANT TO ANYTHING ON THIS LIST
variable "read_whitelist"{
    type = "list"
    default = [
        "185.69.145.60/32",
	"10.37.0.0/18",
	"10.27.0.0/17",
	"10.27.128.0/17"
    ]
}

#ADMIN TO ANYTHING ON THIS LIST - INTENDED FOR CI SERVER
variable "admin_whitelist"{
    type = "list"
    default = [
        "10.0.0.1/32", 
        "10.27.128.0/17" #jenkins deployed to this vpc
    ]
}

variable "environment" {
    default = "deepfrieddragon"
}


