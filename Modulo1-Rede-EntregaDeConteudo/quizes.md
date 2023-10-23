**CHECKPOINT QUESTION**

**Você é um SysOps responsável por oferecer suporte a instâncias EC2 em duas sub-redes privadas denominadas private-subnet-1 e private-subnet-2. Há um novo requisito para algumas das instâncias se conectarem à Internet. As instâncias na sub-rede denominada private-subnet-1 precisam da capacidade de se conectar à Internet, mas as conexões de entrada da rede externa ou da Internet não devem ser permitidas. A sub-rede chamada private-subnet-2 precisa permitir conexões de entrada e saída da Internet. Qual dos itens a seguir você precisa adicionar à sua VPC para habilitar essa conectividade? (Escolha 2)**

1. **Adicione um gateway NAT para permitir que private-subnet-1 se conecte à Internet.**
1. Adicione um Virtual Private Gateway para permitir que private-subnet-1 se conecte à Internet.
1. Adicione um gateway de internet para permitir que private-subnet-1 se conecte à internet.
1. Adicione um gateway do cliente para permitir que private-subnet-2 se conecte à Internet.
1. Adicione um Virtual Private Gateway para permitir que private-subnet-2 se conecte à Internet.
1. **Adicione um gateway de internet para permitir que private-subnet-2 se conecte à internet.**

**CHECKPOINT QUESTION**

**Qual das opções a seguir pode negar explicitamente o acesso de um endereço IP específico a todas as instâncias do EC2 em sua sub-rede?**

1. Security group
1. **Network ACL**
1. VPC Flow Logs
1. VPC endpoint

**CHECKPOINT QUESTION**

**Qual das opções a seguir pode ser usada para conectar sistemas em seu datacenter on-premisses a instâncias do EC2 que possuem apenas endereços IP privados? (Escolha 2)**

1. **VPN site a site**
1. SSH
1. **Direct Connect**
1. VPC Peering

**CHECKPOINT QUESTION**

**Você criou uma nova VPC com o bloco CIDR de 10.0.0.0/16. Você cria 2 sub-redes: 10.0.1.0/24 e 10.0.2.0/24. 10.0.1.0 será uma sub-rede pública e 10.0.2.0 será uma sub-rede privada. Você implanta um gateway NAT com o nome i-7c1507ab em 10.0.1.0 e atribui a ele um endereço IP público. Agora você precisa atualizar sua tabela de rotas para concluir a configuração. Qual das opções a seguir é a listagem correta da tabela de rotas?**

1. Destino: 10.0.0.0/16 Alvo:i-7c1507ab
1. Destino: 10.0.2.0/24 Alvo:i-7c1507ab
1. Destino: 10.0.1.0/24 Alvo:i-7c1507ab
1. **Destino: 0.0.0.0/0 Alvo:i-7c1507ab**

**CHECKPOINT QUESTION**

**Qual dos seguintes serviços permite que você execute uma sessão interativa remota segura para instâncias Windows ou Linux EC2 usando PowerShell ou Bash?**

1. Direct Connect
1. Route 53
1. **Systems Manager Session Manager**
1. Site-to-Site VPN

**CHECKPOINT QUESTION**

**Qual das opções a seguir permite que instâncias do EC2 em duas VPCs se comuniquem usando endereços IP privados?**

1. Route 53
1. Site-to-Site VPN
1. Direct Connect
1. **VPC peering**

**CHECKPOINT QUESTION**

**Qual dos seguintes serviços da AWS pode ser usado para fornecer uma conexão privada, que não usa a Internet, entre instâncias EC2 em seu VPC e seus buckets S3?**

1. Direct Connect
1. VPC Endpoint
1. VPN
1. NAT gateway