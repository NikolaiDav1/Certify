pipeline
  {
  agent any

  stages
    {
    stage('Build')
      {
      steps
        {
        git(url: 'https://github.com/NikolaiDav1/Certify.git')
        sh 'terraform init'
        sh 'export YC_TOKEN=$(yc iam create-token) && \
            export YC_CLOUD_ID=$(yc config get cloud-id) && \
            export YC_FOLDER_ID=$(yc config get folder-id) && \
            terraform plan && \
            terraform apply -auto-approve && \
            export MYHOSTS=$(terraform output buildvmip), && \
            export ANSIBLE_HOST_KEY_CHECKING=False && \
            ansible-playbook -u ubuntu -i $MYHOSTS --private-key "~/.ssh/id_rsa" buildprov.yml' // && \
            // terraform destroy -target yandex_compute_instance.buildvm -auto-approve'
        }
      }

    stage('Prod')
      {
      steps
        {
        sh 'export MYHOSTS=$(terraform output prodvmip), && \
            export ANSIBLE_HOST_KEY_CHECKING=False && \
            ansible-playbook -u ubuntu -i $MYHOSTS --private-key "~/.ssh/id_rsa" prodprov.yml'
        }
      }
    }
  }
