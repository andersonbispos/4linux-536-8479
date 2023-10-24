# Implantação, Provisionamento e Automação

Projetar uma solução de implantação para seu aplicativo é uma parte crítica da criação de um aplicativo bem arquitetado na AWS. Com base na natureza de seu aplicativo e nos serviços subjacentes (computação, armazenamento, banco de dados etc.) necessários, você pode usar os serviços da AWS para criar uma solução de implantação flexível que pode ser adaptada para atender às necessidades de seu aplicativo e de seu organização.

O catálogo de serviços da AWS, em constante crescimento, não apenas complica o processo de decisão de quais serviços irão compor a arquitetura de seu aplicativo, mas também o processo de decidir como você criará, gerenciará e atualizará seu aplicativo. Ao projetar uma solução de implantação na AWS, você deve considerar como sua solução abordará os seguintes recursos:

- **Provisionar**: criar a infraestrutura bruta (Amazon EC2, Amazon Virtual Private Cloud [Amazon VPC], sub-redes etc.) necessários para sua aplicação.
- **Configurar**: personalize sua infraestrutura com base no ambiente, tempo de execução, segurança, disponibilidade, desempenho, rede ou outros requisitos de aplicativos.
- **Implantar**: instale ou atualize seus componentes de aplicativo nos recursos de infraestrutura e gerencie a transição de uma versão anterior do aplicativo para uma nova versão do aplicativo.
- **Escalar**: ajuste de forma proativa ou reativa a quantidade de recursos disponíveis para seu aplicativo com base em um conjunto de critérios definidos pelo usuário.
- **Monitorar**: dê visibilidade aos recursos que são lançados como parte da arquitetura do seu aplicativo. Rastreie o uso de recursos, sucesso/falha da implantação, integridade do aplicativo, logs do aplicativo, desvio de configuração e muito mais.

## Referências

### EC2 Image Builder

- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html
- https://docs.aws.amazon.com/imagebuilder/latest/userguide/how-image-builder-works.html
- https://aws.amazon.com/blogs/mt/migrating-from-hashicorp-packer-to-ec2-image-builder/

### Load Balacing

- https://aws.amazon.com/elasticloadbalancing/
- https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/what-is-load-balancing.html 
- https://docs.aws.amazon.com/AmazonECS/latest/developerguide/load-balancer-types.html
- https://aws.amazon.com/elasticloadbalancing/features
- https://docs.aws.amazon.com/pt_br/elasticloadbalancing/latest/application/introduction.html
- https://docs.aws.amazon.com/prescriptive-guidance/latest/load-balancer-stickiness/subnets-routing.html
- https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html
- https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html
- https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html
- https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-troubleshooting.html#load-balancer-http-error-codes

### Cloud Formation

- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html
- https://github.com/awslabs/aws-cloudformation-templates/blob/master/aws/services/EC2/EC2InstanceWithSecurityGroupSample.yaml
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/CHAP_TemplateQuickRef.html
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/protect-stack-resources.html
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/best-practices.html#limits
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html#troubleshooting-errors-insufficient-iam-permissions
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html#troubleshooting-errors-limit-exceeded
- https://us-east-2.console.aws.amazon.com/servicequotas
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html#troubleshooting-errors-update-rollback-failed
- https://docs.aws.amazon.com/AWSEC2/latest/APIReference/errors-overview.html
- https://us-east-2.console.aws.amazon.com/servicequotas/home/services/vpc/quotas
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-concepts.html
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs-self-managed.html
- https://dev.to/aws-builders/how-to-use-cross-account-iam-role-cob

### Automation

- https://docs.aws.amazon.com/opsworks/latest/userguide/welcome.html
- https://aws.amazon.com/opsworks/stacks/?nc=sn&loc=0
- https://aws.amazon.com/pt/systems-manager/
- https://docs.aws.amazon.com/systems-manager/latest/userguide/run-command.html
- https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager.html

### Deployment Strategies

- https://docs.aws.amazon.com/whitepapers/latest/introduction-devops-aws/deployment-strategies.html
- https://tableless.com.br/tipos-de-deploy/
- https://docs.aws.amazon.com/whitepapers/latest/overview-deployment-options/bluegreen-deployments.html
- https://docs.aws.amazon.com/whitepapers/latest/overview-deployment-options/rolling-deployments.html 