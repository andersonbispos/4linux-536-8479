name: InstallWordPress
description: This document install apache and a test page on Amazon Linux 2
schemaVersion: 1.0

phases:
    - name: build
      steps:
        - name: InstallAppPrereqs
          action: ExecuteBash
          inputs:
            commands:
                - sudo yum install -y httpd
                - sudo systemctl enable httpd
                - sudo systemctl start httpd
        - name: DeployApplication
          action: ExecuteBash
          inputs:
            commands:
                - sudo wget https://raw.githubusercontent.com/andersonbispos/4linux-536-8479/main/Modulo1-Rede-EntregaDeConteudo/scripts/script-webpageinfo.sh -O /opt/script-webpageinfo.sh
                - sudo chmod +x /opt/script-webpageinfo.sh
                - echo '@reboot root /opt/script-webpageinfo.sh' | sudo tee -a /etc/crontab