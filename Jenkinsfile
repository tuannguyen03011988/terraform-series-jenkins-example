pipeline {
  agent any

  // tools {
  //   terraform 'terraform'
  // }

  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-secret-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    terraform_path = '/usr/local/bin'
  }

  stages {
    stage('Init Provider') {
      steps {
        sh '$terraform_path/terraform init'
      }
    }
    stage('Plan Resources') {
      steps {
        sh '$terraform_path/terraform plan'
      }
    }
    stage('Apply Resources') {
      input {
        message "Do you want to proceed for production deployment?"
      }
      steps {
        sh '$terraform_path/terraform apply -auto-approve'
      }
    }
  }
}
