pipeline
  {
  agent any

  stages
    {
    stage('Create vm')
      {
      steps
        {
        git(url: 'https://github.com/NikolaiDav1/Certify.git')
        sh 'whoami'
        sh 'terraform init'
        sh 'export YC_TOKEN=$(yc iam create-token)'
        sh 'export YC_CLOUD_ID=$(yc config get cloud-id)'
        sh 'export YC_FOLDER_ID=$(yc config get folder-id)'
        sh 'terraform plan'
        sh 'terraform apply -auto-approve'
        }
      }
    }
  }
