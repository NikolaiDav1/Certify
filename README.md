# Сертификационное задание
## Подготовка управляющего хоста:

Настройка управляющего хоста:

1.  ВМ control в яндекс клауд:
ubuntu 20.04, cpu 4 ram 4 ssd 15 user с ключом

2.  Установка Jenkins
sudo -i
apt update
apt install mc openjdk-11-jre -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

3.  Установка yc
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash

Копировать yc в /bin

su jenkins
yc init
OAuth token from: https://oauth.yandex.com/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb
yc iam service-account list
yc iam key create --service-account-name srv --output key.json

4.  Установка terraform
wget https://hashicorp-releases.yandexcloud.net/terraform/1.4.2/terraform_1.4.2_linux_amd64.zip
copy terraform в /bin
chmod +x terraform

nano ~/.terraformrc

provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}

5.  Установка ansible
sudo apt-add-repository ppa:ansible/ansible
apt update
apt install ansible
apt install docker.io
apt install python3-pip
pip install docker
ansible-galaxy collection install community.docker

6.  Сгенерить ssh ключ
ssh-keygen

7. Записываем пароль от учетки Docker Hub в файл:
~/hubpassword.txt

8.  Заходим в Jenkins: http://<ip управляющего сервера>:8080/ 
Initial password from /var/lib/jenkins/secrets/
Install default plugins
admin – password – Admin – Nick@ndav.ru
New item – pipe – Pipeline
Pipeline script from SCM
Git - https://github.com/NikolaiDav1/Certify.git

Нажимаем Build now

9. Идем в браузере на <ip продакшн сераера>:8080/mycalcwebapp
И убеждаемся в работоспособности приложения.