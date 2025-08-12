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

source "oracle-oci" "ubuntu-nginx" {
  compartment_id = var.compartment_ocid
  source_ocid    = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaafs7imfvcicboqisaisiz5bbpuzbg5gicwjwvyhnhsvdaowuc3w4q"
  shape          = "VM.Standard.E2.1.Micro"
  ssh_username   = var.ssh_username
  subnet_ocid    = var.subnet_ocid
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
