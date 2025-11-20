pipeline {
    agent any

    stages {
        stage('git clone') {
            steps {
                git branch: 'main', url: 'https://github.com/abhi1563/jenkins.git'
            }
        }
        
        stage('terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('terraform plan') {
            steps {
                sh 'terraform plan'
            }
        }
        
         stage('terraform apply/detsroy') {
            steps {
                sh "terraform ${params.Actions} -auto-approve"
            }
        }
    }
}
