pipeline {
    agent any

//    environment {
//        COMPARTMENT_OCID = credentials('oci_compartment_ocid') // Add in Jenkins
//        SUBNET_OCID      = credentials('oci_subnet_ocid')      // Add in Jenkins
    }

    stages {
        stage('Clone NGINX Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/Karthikbhatkarkada/nginx-test'
            }
        }

        stage('Build OCI Image with Packer') {
            steps {
                sh """
                packer init nginx-ubuntu.pkr.hcl
                packer build \
                    -var compartment_ocid=$COMPARTMENT_OCID \
                    -var subnet_ocid=$SUBNET_OCID \
                    nginx-ubuntu.pkr.hcl
                """
            }
        }
    }
}
