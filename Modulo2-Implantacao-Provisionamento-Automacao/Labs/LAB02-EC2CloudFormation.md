# Implantando uma instância EC2 com CloudFormation

## Introdução

Neste laboratório prático, você assumirá o papel de um desenvolvedor que trabalha com um modelo do CloudFormation para implantar uma instância do EC2 junto com outros recursos.

## Objetivos

- Especificar a AMI e o tipo de instância e implantar uma instância do EC2.
- Definir o tipo de instância como um parâmetro.
- Atualizar o modelo para implantar o EC2 na rede correta com um grupo de segurança personalizado.
- Atualizar e reimplantar uma instância do EC2 com um script `UserData` para instalar o Apache.
- Validar a abertura da página de teste do Apache.

Faça login no seu ambiente ativo da AWS. Certifique-se de estar na região de N. Virginia (us-east-1) durante todo o laboratório.

## Ajuste o template e implante uma instância do EC2

### Especifique o tipo de instância como parâmetro

1. Abra o template `base.yaml` CloudFormation no GitHub do curso.
1. No canto superior direito, clique em `Download raw file`.
1. Salve o arquivo em sua máquina local e, se possível, abra o arquivo em um editor de texto com realce de sintaxe (por exemplo, VSCode).
1. Abra o template do  CloudFormation no editor de texto escolhido e revise os recursos de rede que estão sendo implantados: VPC, sub-redes, gateway de internet, tabela de rotas pública, associações de tabela de rota de sub-rede, etc.
1. Role para baixo até `EC2Instance1` na parte inferior do template e observe como `InstanceType` é definido como `t3.micro`; você atualizará essa configuração para um parâmetro.
1. Para fazer isso, role até o topo do modelo.
1. No final da linha `Description: Deploy a vpc and an EC2 instance - Base`, pressione `Enter`.
1. Insira as seguintes configurações de parâmetro:
    ```
      Parameters:
        InstanceTypeParameter:
          Type: String
          Default: t3.micro
          AllowedValues:
            - t3.micro
            - t3.small
            - t3.medium
            - t3.large
          Description: "Selecione um tipo de instância"
    ```
    > O valor `Parameters` e `InstanceTypeParameter` devem estar alinhados a `Description`
1. Copie `InstanceTypeParameter` e role para baixo até `EC2Instance1` na parte inferior do modelo.
1. Selecione t3.micro e exclua esse valor.
1. Digite `!Ref` e um espaço e cole em `InstanceTypeParameter`.
    > O valor InstanceType agora deve ficar: `InstanceType: !Ref InstanceTypeParameter`.

> Você pode ter problemas de identação ao copiar/colar do guia de laboratório; em caso afirmativo, você pode consultar o tempalte completo `template_final` no GitHub.

> Use o template final apenas como referência para validar que as alterações feitas no seu arquivo estão com a mesma identação o `template_final`.

### Especifique o ID da AMI

1. Na Console de gerenciamento da AWS navegue até o painel de gerenciamento de EC2.
1. Na barra de menu lateral navegue até `Images` e em seguida selecione `AMI Catalog`.
1. Na aba `Quickstart AMIs`. Em `All products` selecone o códito da ami mais recente do Amazon Linux, um código como `ami-0f34c5ae932e6f0e4`.
1. Navegue de volta ao seu editor de texto.
1. Em `EC2Instance1`, na parte inferior do template, substitua `<INSERT AMI>` pelo ID da AMI que você acabou de copiar. Certifique-se de deixar as aspas simples ao redor do ID da AMI.
1. Salve seu arquivo de modelo do CloudFormation.

## Implante os recursos na conta da AWS

1. Navegue de volta para a guia Console de gerenciamento da AWS.
1. Abra o CloudFormation selecionando-o na barra de atalhos superior esquerda ou pesquisando e selecionando CloudFormation.
1. No canto superior direito, clique em `Create stack` e em seguida `With new resources (standard)`.
1. Em `Prerequisite - Prepare template` > `Prepare template`, certifique-se de que a opção `Template is ready` está selecionada.
1. Em `Specify template` > `Template source`, selecione `Upload a template file`.
1. Em `Upload a template file`, clique em `Choose file`.
1. Selecione seu arquivo `template_base.yml` (ou seja, o arquivo de modelo do CloudFormation que você acabou de salvar) e clique em Abrir.
1. Clique em Avançar.
1. Em `Stack name`, insira `lab-ec2-stack`.
1. Em `InstanceTypeParameter`, verifique se `t3.micro` está selecionado.
1. Clique em Avançar até chegar à página Revisão.
1. Clique em `Submit`.
1. No canto superior direito, clique no ícone Atualizar para confirmar que sua stack está sendo implantada. Pode levar alguns minutos até que o status do `lab-ec2-stack` seja mostrado como `CREATE_COMPLETE`.
1. Assim que o status for exibido como `CREATE_COMPLETE`, clique na guia `Resources`.
1. Ao lado do `EC2Instance1`, clique no `Physical ID`; isso deve abrir uma nova guia Instâncias.
1. Clique na caixa de seleção ao lado de `Instance1`.
1. Na guia `Details`, role para baixo até a seção `VPC ID/Subnet ID` e observe que os nomes de ID do modelo não foram aplicados (ou seja, LAB_SYSOPS_VPC e LAB_SYSOPS_PUBLIC_1), o que significa que foi implantado em uma VPC diferente.
1. Em `VPC ID`, clique na VPC listada; isso deve abrir uma nova guia de gerenciamento de VPC.
1. Clique na caixa de seleção ao lado do ID da VPC.
1. Nas configurações do VPC, clique na barra de rolagem e arraste-a totalmente para a direita; observe que esta é a VPC padrão.
1. Role todo o caminho de volta para a esquerda.
1. No canto superior esquerdo, clique no X ao lado do VPC ID; agora você deve ver o `LAB_SYSOPS_VPC`.

## Atualize o template para implantar o EC2 na rede correta com um grupo de segurança personalizado

1. Navegue de volta para o modelo CloudFormation em seu editor de texto.
1. Em `EC2Instance1`, na parte inferior do modelo, coloque o cursor no final da linha AMI ID.
1. Pressione `Enter` para iniciar uma nova linha (linha 181). Em seguida, defina as seguintes configurações:
```
   NetworkInterfaces:
     - GroupSet:
         - !Ref EC2SecurityGroup1
       AssociatePublicIpAddress: 'true'
       DeviceIndex: '0'
       DeleteOnTermination: 'true'
       SubnetId: !Ref VPC1PublicSubnet1
```
> Nota: `NetworkInterfaces` deve ser alinhado com `ImageId` acima dele (recuado com seis espaços). Certifique-se de que `- GroupSet:` está recuado oito espaços e `- !Ref EC2SecurityGroup1` está recuado quatro espaços depois de - GroupSet:.
1. Abaixo de Tags, coloque o cursor no final da linha Value: `Instance1`.
1. Pressione `Enter` para iniciar uma nova linha (linha 191).
1. Mova o cursor para a frente dessa nova linha e recue dois espaços. O cursor deve estar alinhado com o bloco `EC2Instance1`, indicando que você está iniciando um novo recurso.
1. Defina as seguintes configurações de grupo de segurança:
    ```
      EC2SecurityGroup1:
        Type: 'AWS::EC2::SecurityGroup'
        Properties:
          GroupDescription: EC2SecurityGroupPublic
          VpcId: !Ref VPC1
          SecurityGroupIngress:
          - CidrIp: 0.0.0.0/0
            FromPort: 22
            ToPort: 22
            IpProtocol: tcp
          - CidrIp: 0.0.0.0/0
            FromPort: 80
            ToPort: 80
            IpProtocol: tcp
    ```
1. Pressione Enter para iniciar uma nova linha. Certifique-se de que o cursor esteja alinhado com SecurityGroupIngress.
1. Defina as seguintes configurações de nome de grupo e tag (certifique-se de que GroupName esteja alinhado com SecurityGroupIngress):
    ```
    GroupName: LAB_SYSOPS_SG
    Tags:
      - Key: Name
        Value: LAB_SYSOPS_SG
    ```
1. Salve seu arquivo de template do CloudFormation.

## Atualize e reimplante uma instância do EC2 com um script UserData para instalar o Apache

1. Em `EC2Instance1`, na parte inferior do modelo, coloque o cursor no final da linha AMI ID.
1. Pressione Enter para iniciar uma nova linha e mova o cursor para a frente dessa nova linha (linha 181). Em seguida, pressione a barra de espaço seis vezes para garantir que o cursor fique alinhado com `ImageId`.
1. Adicione o seguinte script de UserData. `UserData` deve ser alinhado com ImageId acima dele e o restante do script é avançado:
    ```
      UserData: 
        Fn::Base64:
          !Sub |
            #!/bin/bash
            yum install -y httpd
            systemctl start httpd
            systemctl enable httpd
            sudo echo "<html><h1>Hello SysOps Admin</h1></html>" > /var/www/html/index.html
    ```
> Para a linha 181, deve haver seis espaços antes de `UserData`. A linha 182 está oito espaços antes de Fn::Base64. A linha 183 tem 10 espaços antes de !Sub. A linha 184 tem 12 espaços #!/bin/bash (assim como o restante deste trecho de código).
1. Save the CloudFormation template file again.

### Reimplante o modelo do CloudFormation substituindo o modelo existente

1. Navegue de volta para a guia do console do CloudFormation.
1. À esquerda, em `Stacks`, verifique se `lab-ec2-stack` está selecionado.
1. No canto superior direito, clique em `Update`.
1. Em `Prerequisite - Prepare template`, certifique-se de que `Replace current template` esteja selecionado.
1. Em `Specify template > Template source`, selecione `Upload a template file`.
1. Em `Upload a template file`, clique em `Choose file`.
1. Selecione seu arquivo `template_base.yml`.
1. Clique em `Next`.
1. Em `InstanceTypeParameter`, verifique se `t3.micro` está selecionado.
1. Clique em `Next` até chegar à página Revisão.
1. Role para baixo até `Changes`; em `Action`, você deve ver um conjunto de alterações chamado `Modify`, em que Substituição é definido como `True`.
1. Clique em `Submit`.
1. No canto superior direito, clique no ícone `Atualizar` para confirmar que sua pilha está sendo implantada. Pode levar alguns minutos até que o Status seja mostrado como `UPDATE_COMPLETE`.
1. Assim que o status for exibido como `UPDATE_COMPLETE`, clique na guia Recursos.

## Verifique o carregamento da página de teste do Apache

1. Ao lado do `EC2Instance1`, clique no `Physical ID`; isso deve abrir uma nova guia Instâncias.
1. Clique na caixa de seleção ao lado de `Instance1`.
1. Na guia `Details`, role para baixo até a seção `VPC ID/Subnet ID` e observe que os nomes de ID foram atualizados para `LAB_SYSOPS_VPC` e `LAB_SYSOPS_PUBLIC_1`.
1. Clique na guia `Security`.
1. Em `Security Groups`, verifique se você está no grupo de segurança `LAB_SYSOPS_SG` que acabou de criar.
1. Navegue de volta para a guia `Details`.
1. Em Endereço IPv4 público, copie o endereço IP listado.
1. Abra uma nova guia e cole esse endereço IP; você deve ver a página de teste confiturado em `UserData`.

**Lembre de deletar a stack para apagar os recursos criados ao finalizar o lab**