packer {
  required_plugins {
    oracle = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/oracle"
    }
  }
}

variable "compartment_ocid" {}
variable "subnet_ocid" {}
variable "ssh_username" {
  default = "ubuntu"
}
variable "ssh_private_key_file" {
  default = "/home/ubuntu/.ssh/oci_key"
}

variable "ssh_public_key_file" {
  default = "/home/ubuntu/.ssh/oci_key.pub"
}

source "oracle-oci" "ubuntu-nginx" {
  compartment_ocid     = "ocid1.tenancy.oc1..aaaaaaaa6jvn6ty3gevdog7phzcnbh7x3ek4suj4cwyd7imjhe62qwv7x2iq"
  subnet_ocid          = "ocid1.subnet.oc1.ap-hyderabad-1.aaaaaaaa4nwj6qaqilt7vfwfgq5ygal266s57effy6hotkv3lozgitdesviq"
  availability_domain  = "yFYg:AP-HYDERABAD-1-AD-1"
  shape                = "VM.Standard.E2.1.Micro"
  base_image_ocid      = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaafs7imfvcicboqisaisiz5bbpuzbg5gicwjwvyhnhsvdaowuc3w4q"
  ssh_username         = "ubuntu"
  ssh_private_key_file = var.ssh_private_key_file
}

build {
  sources = ["source.oracle-oci.ubuntu-nginx"]

  provisioner "file" {
    source      = "install_nginx.sh"
    destination = "/tmp/install_nginx.sh"
  }

  provisioner "file" {
    source      = "nginx.conf"
    destination = "/tmp/nginx.conf"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/install_nginx.sh",
      "sudo /tmp/install_nginx.sh"
    ]
  }
}
