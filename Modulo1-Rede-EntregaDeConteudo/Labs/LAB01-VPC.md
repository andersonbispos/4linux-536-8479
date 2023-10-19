# LAB1 - Criando uma VPC e componentes associados

## Introdução

Uma VPC da AWS consiste em vários componentes, e entender o relacionamento entre os componentes de rede é uma parte fundamental da compreensão da funcionalidade e dos recursos gerais da AWS. Neste laboratório prático, criaremos uma VPC com um gateway de Internet, bem como criaremos sub-redes em várias zonas de disponibilidade.

### Objetivos:

- Criar uma VPC
- Crie uma sub-rede pública e privada em diferentes zonas de disponibilidade
- Crie duas listas de controle de acesso à rede (NACLs) e associe cada uma à sub-rede apropriada
- Crie um gateway da Internet e anexe-o à VPC
- Crie duas tabelas de rotas e associe-as à sub-rede correta

Faça login no seu ambiente ativo da AWS. Certifique-se de estar na região de N. Virginia (us-east-1) durante todo o laboratório.

## Criar uma VPC

1. Navegue até VPC.
1. No menu da barra lateral, navegue até **Virtual private cloud** e selecione **Your VPCs**.
1. À direita, clique em **Create VPC**
1. Em `Resources to create` selecione: `VPC Only`
1. Defina as configurações de VPC:
    - Tag de nome: No campo de texto, digite: `vpc1`.
    - Bloco CIDR IPv4: No campo de texto, insira `172.16.0.0/16`.
1. Deixe as outras configurações como padrão e clique em Criar VPC.
    > A VPC esta criada, mas não possui um gateway de internet, sub-redes ou qualquer outra funcionalidade.

## Criar uma sub-rede pública e privada em diferentes zonas de disponibilidade

1. No menu da barra lateral, selecione **Subnets**.
1. À direita, clique em **Create Subnet**
1. Configure a sub-rede pública:
    - VPC ID: Use o menu suspenso para selecionar `vpc1`.
    - Nome da sub-rede: no campo de texto, insira `Public1`.
    - Zona de disponibilidade: Use o menu suspenso para selecionar `us-east-1a`.
    - Bloco CIDR IPv4: No campo, selecione `172.16.1.0/24`. Todas as instâncias do EC2 atribuídas a esta sub-rede terão um prefixo de endereço IP de `172.16.1`.
1. Clique em `Create subnet`
    > A sub-rede pública será criada.
1. À direita, clique em Criar sub-rede novamente.
1. Configure a sub-rede privada:
    - VPC ID: Use o menu suspenso para selecionar `vpc1`.
    - Nome da sub-rede: no campo de texto, insira `Private1`.
    - Zona de disponibilidade: Use o menu suspenso para selecionar `us-east-1b`.
    - Bloco CIDR IPv4: No campo, selecione `172.16.2.0/24`.
1. Clique em Criar sub-rede.
    > A sub-rede privada será criada.

##  Crie duas listas de controle de acesso à rede (NACLs) e associe cada uma à sub-rede adequada

### Criar e configurar um NACL público

1. No menu da barra lateral, navegue até **Security** e selecione **Network ACLs**.
    > Você deve ver um NACL padrão disponível. No entanto, você não usará este NACL.
1. À direita, clique em `Create Network ACL`.
1. Configurar o NACL público:
    - Nome: No campo de texto, digite `PublicNACL`.
    - VPC: Use o menu suspenso para selecionar `vpc1`.
1. Clique em `Create Network ACL`.
1. Depois que o NACL for criado, marque a caixa de seleção ao lado de PublicNACL.
1. Selecione a guia `Inboud rules`e clique em `Edit inbound rules`.
1. Adicione duas regras de entrada:
    - Clique em `Add new rule`.
    - Preencha os detalhes da regra:
        - Número da regra: No campo de texto, insira `100`.
        - Tipo: Use o menu suspenso para selecionar `HTTP (80)`.
        - Origem: Deixe a origem como `0.0.0.0/0`.
    - Clique em `Add new rule` novamente.
    - Preencha os detalhes da regra:
        - Número da regra: No campo de texto, digite `110`.
        - Tipo: Use o menu suspenso para selecionar `SSH (22)`.
        - Source: Deixe a source como `0.0.0.0/0`.
1. Clique em `Save changes`.
1. Nos detalhes do `PublicNACL`, selecione a guia `Outbound rules` e clique em `Edit outboud rules`.
1. Adicione uma regra de saída:
    - Clique em Adicionar nova regra.
    - Preencha os detalhes da regra:
        - Número da regra: No campo de texto, insira `100`.
        - Tipo: deixe o tipo como `Custom TCP`.
        - Intervalo de portas: No campo de texto, digite `1024-65535`.
        - Destino: Deixe o destino como `0.0.0.0/0`.
1. Clique em `Save changes`.
1. Nos detalhes do `PublicNACL`, selecione a guia `Subnet associations` e clique em `Edit subnet associations`.
1. Marque a caixa de seleção ao lado da sub-rede `Public1`.
1. Clique em `Save changes` para associar sua NACL pública à sub-rede pública.

### Criar e configurar um NACL privado

1. Na página Network ACLs, clique em `Create network ACL`.
1. Configurar o NACL privado:
    - Nome: No campo de texto, digite `PrivateNACL`.
    - VPC: Use o menu suspenso para selecionar `vpc1`.
1. Clique em `Create Network ACL`.
1. Marque a caixa de seleção ao lado de `PrivateNACL`, garantindo que seja o único NACL selecionado.
1. Selecione a guia `Inboud rules`e clique em `Edit inbound rules`.
1. Adicione uma regra de entrada:
    - Clique em `Add new rule`.
    - Preencha os detalhes da regra:
        - Número da regra: No campo de texto, insira 100.
        - Tipo: Use o menu suspenso para selecionar `SSH (22)`.
        - Source: No campo de texto, digite `172.16.1.0/24`.
1. Clique em `Save changes`.
1. Nos detalhes do `PrivateNACL`, selecione a guia `Outbound rules` e clique em `Edit outboud rules`.
1. Adicione uma regra de saída:
    - Clique em `Add new rule`.
    - Preencha os detalhes da regra:
        - Número da regra: No campo de texto, insira `100`.
        - Tipo: deixe o tipo como `Custom TCP`.
        - Intervalo de portas: No campo de texto, digite `1024-65535`.
        - Destino: Deixe o destino como `0.0.0.0/0`.
1. Clique em `Save changes`.
1. Nos detalhes do `PrivateNACL`, selecione a guia `Subnet associations` e clique em `Edit subnet associations`.
1. Marque a caixa de seleção ao lado da sub-rede Private1.
1. Clique em `Save changes` para associar sua NACL privado à sub-rede privada.

## Crie um gateway da Internet e conecte-o à VPC

1. No menu da barra lateral, navegue até Virtual private cloud e selecione Internet gateways.
1. À direita, clique em Criar gateway de internet.
1. No campo Tag de nome, digite `IGW`.
1. Clique em `Create internet gateway`.
1. Depois que o gateway da Internet for criado, use o menu suspenso `Actions` para selecionar `Attach to VPC`.
1. No campo VPCs disponíveis, selecione `vpc1`.
1. Clique em `Attach internet gateway`.
    > Seu gateway de internet agora deve estar em um estado Anexado.

## Crie duas tabelas de rotas e associe-as à sub-rede correta

### Criar as tabelas de rota

1. No menu da barra lateral, selecione `Route tables`.
    > Você deve ver duas tabelas de rotas padrões disponíveis, uma da rede default e uma da nossa rede vpc1. No entanto, você não usará estas tabelas de rotas.
1. À direita, clique em `Create route table`.
1.  Configure a tabela de rotas públicas:
    - Nome: No campo de texto, digite `PublicRT`.
    - VPC: Use o menu suspenso para selecionar `vpc1`.
1. Clique em `Create route table`.
1. No menu da barra lateral, selecione `Route tables` novamente.
1. À direita, clique em Criar tabela de rota.
1. Configure a tabela de rotas privadas:
    - Nome: No campo de texto, digite `PrivateRT`.
    - VPC: Use o menu suspenso para selecionar `vpc1`.
1. Clique em `Create route table`.

### Associar as tabelas de rotas à sub-rede correta

1. No menu da barra lateral, selecione `Route tables` novamente.
1. Marque a caixa de seleção ao lado da tabela de rotas `PublicRT`, garantindo que esta seja a única tabela de rotas selecionada.
1. Adicione uma rota apontando para o `internet gateway`.
    - Selecione a guia Rotas e clique em `Edit routes`
    - Clique em `Add route` para adicionar uma rota apontando como alvo gateway da Internet.
    - No campo `Destination`, selecione `0.0.0.0/0`.
    - No campo `Target`, selecione `Internet Gateway` e, em seguida, selecione o gateway `IGW`.
1. Clique em `Save Changes`.
    > Agora, qualquer tráfego que não seja destinado à rede local será roteado para o gateway de internet.
1. No menu da barra lateral, selecione `Route tables` novamente e verifique se a caixa de seleção ao lado de PublicRT está marcada.
1. Associe a tabela de rotas à sub-rede pública:
    - Selecione a guia `Subnet associations`.
    - Na seção `Subnets without explicit associations`, clique em `Edit subnet associations`.
    - Marque a caixa de seleção ao lado da sub-rede `Public1`.
    - Clique em `Save associations`.
1. No menu da barra lateral, selecione `Route tables` novamente.
1. Marque a caixa de seleção ao lado da tabela de rotas `PrivateRT`, garantindo que esta seja a única tabela de rotas selecionada.
1. Selecione a guia Rotas e observe que a rota local já existe. Para esta tabela de rotas, você não precisa criar outra rota para o gateway da Internet.
1. Associe a tabela de rotas à sub-rede privada:
    - Selecione a guia `Subnet associations`.
    - Na seção `Subnets without explicit associations`, clique em `Edit subnet associations`.
    - Marque a caixa de seleção ao lado da sub-rede `Private1`.
    - Clique em `Save associations`.

## Conclusão

Deixe a VPC criada para os próximos LABS

### Extra

Crie uma instancia na subnet public (usando a ami de Amazon Linux), acesse a instância via SSH e teste se o comando `sudo yum update -y` está funcionando corretamente.

** Para evitar cobranças, lembre-se sempre de remover os recursos criados e apagar ou parar as instâncias. **