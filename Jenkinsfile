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
        sh 'terraform plan'
        sh 'terraform apply -auto-approve'
        }
      }
    }
  }
