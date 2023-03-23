pipeline
  {
  agent any

  stages
    {
    stage('Create buildvm')
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
            terraform output -json external_ip_address_vm_1 > ~/myhosts'
        sh 'ansible-playbook -u ubuntu -i "~/myhosts"  --private-key "~/.ssh/id_rsa" buildprovision.yml'
        }
      }
    }
  }
