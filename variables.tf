#READ ONLY ACCESS GRANT TO ANYTHING ON THIS LIST
variable "read_whitelist"{
    type = "list"
    default = [
        "185.69.145.60/32"

    ]
}

#ADMIN TO ANYTHING ON THIS LIST - INTENDED FOR CI SERVER
variable "admin_whitelist"{
    type = "list"
    default = [
        "10.0.0.1/32", 
        "10.0.0.2/32"
    ]
}

variable "environment" {
    default = "deepfrieddragon"
}


