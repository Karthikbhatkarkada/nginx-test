packer {
  required_plugins {
    oracle = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/oracle"
    }
  }
}

source "oracle-oci" "ubuntu-nginx" {

  user_ocid=ocid1.user.oc1..aaaaaaaaaoc2keqeg3eivr4vadd4llduiput5fu5ftprtps3rt5o2rzmhz6q
  fingerprint=49:85:65:68:89:5f:9e:4e:59:a8:e9:11:68:f5:b0:07
  key_file=/home/ubuntu/.oci/oci_api_key.pem
  tenancy_ocid=ocid1.tenancy.oc1..aaaaaaaa6jvn6ty3gevdog7phzcnbh7x3ek4suj4cwyd7imjhe62qwv7x2iq
  region=ap-hyderabad-1 

  compartment_ocid     = "ocid1.tenancy.oc1..aaaaaaaa6jvn6ty3gevdog7phzcnbh7x3ek4suj4cwyd7imjhe62qwv7x2iq"
  subnet_ocid          = "ocid1.subnet.oc1.ap-hyderabad-1.aaaaaaaa4nwj6qaqilt7vfwfgq5ygal266s57effy6hotkv3lozgitdesviq"
  availability_domain  = "yFYg:AP-HYDERABAD-1-AD-1"
  shape                = "VM.Standard.E2.1.Micro"
  base_image_ocid      = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaafs7imfvcicboqisaisiz5bbpuzbg5gicwjwvyhnhsvdaowuc3w4q"
  ssh_username         = "ubuntu"
  ssh_private_key_file = "/var/lib/jenkins/.oci/oci_api_key.pem"
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
