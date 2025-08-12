pipeline {
    agent any

    stages {
        stage('Clone NGINX Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/Karthikbhatkarkada/nginx-test.git'
            }
        }

        stage('Build OCI Image with Packer') {
            steps {
                sh """
                packer init nginx-ubuntu.pkr.hcl
                packer build nginx-ubuntu.pkr.hcl
                """
            }
        }
    }
}
