# Trabalhando com fluxos de logs de VPC para monitoramento de rede

## Introdução

O monitoramento do tráfego de rede é um componente crítico das práticas recomendadas de segurança para atender aos requisitos de conformidade, investigar incidentes de segurança, rastrear as principais métricas e configurar notificações automatizadas. O AWS VPC Flow Logs captura informações sobre o tráfego IP indo e vindo de interfaces de rede em sua VPC. Neste laboratório prático, configuraremos e usaremos VPC Flow Logs publicados no Amazon CloudWatch, criaremos métricas e alertas personalizados com base nos logs do CloudWatch para entender as tendências e receber notificações sobre possíveis problemas de segurança e usaremos o Amazon Athena para consultar e analisar os logs de fluxo do VPC armazenados no S3.

Execute o template do CloudFormation fornecido com o laboratório para preparação do ambiente.

### Objetivos

- Crie um CloudWatch Log Group e um VPC Flow Log para o CloudWatch
- Criar filtros e alertas do CloudWatch
- Use o CloudWatch Logs Insights
- Analisar dados de logs de fluxo de VPC no Athena

## Crie um grupo de logs do CloudWatch e logs de fluxo de VPC para o CloudWatch

### Criar um log de fluxo de VPC para S3

1. Navegue até VPC.
1. No painel VPC, selecione o cartão VPCs.
1. Marque a caixa de seleção ao lado da `sysops-vpc`.
1. Na parte inferior da tela, selecione a guia `Flow logs`.
1. À direita, clique em `Create flow log`.
1. Preencha os detalhes do log de fluxo:
    - **Nome**: Você pode deixar este campo em branco.
    - **Filtro**: Certifique-se de que Todos esteja selecionado.
    - **Intervalo máximo de agregação**: Selecione 1 minuto.
    - **Destino**: selecione `Send to an Amazon S3 bucket`.
1. Obtenha o ARN do bucket S3:
    - Em uma nova guia do navegador, navegue até S3.
    - Clique no nome bucket criado via CloudFormation.
    - Clique na aba `Properties`
    - Em `Bucket overview` clique no ícone antes do ARN do bucket para copiar ARN.
1. Navegue de volta para a guia VPC no Console da AWS e preencha o restante dos detalhes do log de fluxo:
    - ARN do bucket S3: no campo de texto, cole o ARN do bucket S3 copiado.
    - Formato de registro de log: verifique se o formato padrão da AWS está selecionado.
1. Deixe os outros campos como configurações padrão e clique em `Create flow log`.
    > Seu log de fluxo para um bucket S3 está criado.
1. Na página `Your VPCs`, selecione a guia Flow logs.
1. Revise os detalhes do log de fluxo e verifique se ele mostra um status Ativo.
1. Navegue de volta para a guia S3 Management Console.
1. Selecione o nome do seu bucket e, em seguida, selecione a guia Permissões.
1. Revise a política de bucket e observe que ela foi modificada automaticamente pela AWS quando você cria logs de fluxo para que os logs de fluxo possam gravar no bucket.
    > Observação: pode levar de 5 a 15 minutos para que os logs de fluxo sejam exibidos. Você pode continuar trabalhando nos outros objetivos do laboratório enquanto espera que os logs de fluxo sejam preenchidos.

### Crie o CloudWatch Log Group e o VPC Flow Log

1. Em uma nova guia do navegador, navegue até **CloudWatch**.
1. No menu da barra lateral do CloudWatch, navegue até **Logs** e selecione **Log groups**.
1. Clique em `Create log group`.
1. No campo Nome do grupo de logs, insira VPCFlowLogs.
1. Clique em `Create`.
1. Navegue de volta para a guia `VPC Management Console` e verifique se a guia Flow logs ainda está selecionada.
1. À direita, clique em `Create flow log`.
1. Preencha os detalhes do log de fluxo:
    - **Nome**: Você pode deixar este campo em branco.
    - **Filtro**: Certifique-se de que Todos esteja selecionado.
    - **Intervalo máximo de agregação**: Selecione 1 minuto.
    - **Destination**: Certifique-se de que Send to CloudWatch Logs esteja selecionado.
    - **Grupo de logs de destino**: Clique no campo e selecione seu grupo de logs VPCFlowLogs.
    - **Função do IAM**: use a lista suspensa para selecionar a função que contenha a string `VPCFlowLogsRole`.
    - **Formato de registro de log**: verifique se o formato padrão da AWS está selecionado.
1. Clique em `Create flow log`.
    > Seu log de fluxo para o CloudWatch está criado.
1. Na página Your VPCs, verifique se a guia Flow logs está selecionada.
1. Revise os detalhes do log de fluxo e verifique se o novo log de fluxo mostra um estado Ativo.
1. Navegue de volta para a guia `CloudWatch Management Console`.
1. Selecione o nome do grupo de logs `VPCFlowLogs`.
1. Você deve ver que não há fluxos de log no momento. Lembre-se de que pode levar algum tempo até que os logs de fluxo comecem a preencher os dados.

## Gerar tráfego de rede

1. Em uma nova guia do navegador, navegue até EC2.
1. Conecte-se na instância `WebServer` usando a guia `EC2 Instance Connect`
    > É possível que você precise iniciar a instânica
    > Agora que você se conectou ao terminal com sucesso, os logs de fluxo da VPC serão registrados para esta conexão.
1. Sair do terminal:
    ```
    logout
    ```
1. Feche a aba do navegador aberta pelo `EC2 Instance Connect`
1. Navegue de volta para a guia `EC2 Management Console`.
1. Atualize o security group da instância do EC2:
    - Marque a caixa de seleção ao lado da instância `WebServer` e, em seguida, use o menu suspenso `Actions` para selecionar Security > `Change security groups`.
    - Na seção Grupos de segurança associados, clique em Remover à direita dos detalhes do grupo de segurança para remover o grupo `PublicSG`.
    - Use a barra de pesquisa na seção Grupos de segurança associados para selecionar o grupo de segurança `HTTPOnlySG`.
    - Clique em Adicionar grupo de segurança e clique em Salvar.
1. Tente novamente se conectar a instância `WebServer`
    > Desta vez, sua conexão deve expirar porque você removeu o acesso SSH com a alteração do grupo de segurança. Isso será registrado nos logs de fluxo de VPC como um registro rejeitado.
1. Feche a aba do navegador aberta pelo `EC2 Instance Connect`
1. Navegue de volta para a guia EC2 Management Console.
1. Reverta o grupo de segurança da instância EC2 de volta para `PublicSG`:
    - Certifique-se de que a instância `WebServer` esteja selecionada e, em seguida, use o menu suspenso `Actions` para selecionar Security > `Change security groups`.
    - Na seção Grupos de segurança associados, clique em Remover à direita dos detalhes do grupo de segurança para remover o grupo `HTTPOnlySG`.
    - Use a barra de pesquisa na seção Grupos de segurança associados para selecionar o grupo de segurança `PublicSG`.
    - Clique em Adicionar grupo de segurança e clique em Salvar.
1. Tente novamente se conectar a instância `WebServer`
    > Desta vez, a conexão deve ser aceita.

## Criar filtros e alertas do CloudWatch

### Criar um filtro de métricas de log do CloudWatch

1. Navegue de volta para a guia CloudWatch Management Console.
1. No menu da barra lateral do CloudWatch, navegue até Logs e selecione Log groups.
1. Selecione o nome do grupo de logs VPCFlowLogs.
    > Agora você deve ver um fluxo de log. Se você ainda não vir um fluxo de log listado, aguarde mais alguns minutos e atualize a página até que os dados apareçam.
1. Selecione o nome do fluxo de log listado e revise os dados.
1. Use a trilha de navegação na parte superior da página para selecionar VPCFlowLogs.
1. Selecione a guia `Metric filters` e clique em `Create metric filter`.
1. No campo `Filter pattern`, insira o seguinte padrão para rastrear tentativas falhadas de SSH na porta 22:
    ```
    [versão, conta, eni, fonte, destino, srcport, destport="22", protocolo="6", pacotes, bytes, windowstart, windowendaction="REJECT",    flowlogstatus]
    ```
1. Use o menu suspenso `Select log data to test` para selecionar `Custom log data`.
1. No campo Mensagens de evento de log, substitua os dados de log existentes pelo seguinte:
    ```
    2 086112738802 eni-0d5d75b41f9befe9e 61.177.172.128 172.31.83.158 39611 22 6 1 40 1563108188 1563108227 REJECT OK
    2 086112738802 eni-0d5d75b41f9befe9e 182.68.238.8 172.31.83.158 42227 22 6 1 44 1563109030 1563109067 REJECT OK
    2 086112738802 eni-0d5d75b41f9befe9e 42.171.23.181 172.31.83.158 52417 22 6 24 4065 1563191069 1563191121 ACCEPT OK
    2 086112738802 eni-0d5d75b41f9befe9e 61.177.172.128 172.31.83.158 39611 80 6 1 40 1563108188 1563108227 REJECT OK
    ```
1. Clique em `Test pattern` e analise os resultados.
1. Clique em Avançar.
1. Preencha os detalhes da métrica:
    - Nome do filtro: no campo de texto, digite `dest-port-22-rejects`.
    - Namespace da métrica: no campo de texto, insira um nome (por exemplo, `vpcflowlogs`).
    - Nome da métrica: no campo de texto, insira `SSH Rejects`.
    - Valor da métrica: no campo de texto, insira `1`.
1. Deixe os outros campos em branco e clique em `Avançar`.
1. Revise os detalhes da métrica e clique em Criar filtro de métrica.

### Criar um alarme com base no filtro de métrica

1. Após a criação do filtro de métrica, certifique-se de que a guia Filtros de métrica esteja selecionada.
1. Nos detalhes do filtro de métrica, marque a caixa de seleção à direita do filtro `dest-port-22-reject.`.
1. À direita, clique em `Create alarm`.
    > A página Alarmes é aberta automaticamente em uma nova guia do navegador.
1. Especifique as condições da métrica:
    - Period: Use o menu suspenso para selecionar `1 minuto`.
    - Threshold type: certifique-se de que `Static` esteja selecionado.
    - Whenever SSH Rejects is...: Selecione `Greater/Equal`.
    - than...: No campo de texto, digite 1.
    > A métrica acionará um alarme sempre que houver uma ou mais mensagens de rejeição em um período de um minuto.
1. Clique em `Next`.
1. Configure as ações de alarme:
    - Gatilho de estado de alarme: certifique-se de que In alarm esteja selecionado.
    - Envie uma notificação para o seguinte tópico do SNS: Selecione Criar um novo tópico.
    - Criar um novo tópico...: Deixe o nome do tópico padrão.
    - Endpoints de e-mail que receberão a notificação...: No campo de texto, insira um endereço de e-mail (pode ser seu endereço de e-mail real ou um endereço de amostra como user@example.com) e clique em Criar tópico.
    > Observação: se você inseriu seu endereço de e-mail real, abra sua caixa de entrada de e-mail e clique no link Confirmar assinatura recebido no e-mail do SNS.
1. Clique em `Next`.
1. No campo `Alarm Name`, insira `SSH Rejects`.
1. Clique em `Next`.
1. Revise os detalhes do alarme e clique em Criar alarme.
    > O alarme é criado, mas levará algum tempo para começar a preencher os dados.

### Gerar tráfego para alertas

1. Navegue de volta para a guia `EC2 Management Console`  e reconcte-se à instância `WebServer`.
1. Sair do terminal:
    ```
    logout
    ```
1. Feche a aba do navegador aberta pelo `EC2 Instance Connect`
1. Navegue de volta para a guia `EC2 Management Console`.
1. Atualize o security group da instância do EC2:
    - Marque a caixa de seleção ao lado da instância `WebServer` e, em seguida, use o menu suspenso `Actions` para selecionar Security > `Change security groups`.
    - Na seção Grupos de segurança associados, clique em Remover à direita dos detalhes do grupo de segurança para remover o grupo `PublicSG`.
    - Use a barra de pesquisa na seção Grupos de segurança associados para selecionar o grupo de segurança `HTTPOnlySG`.
    - Clique em Adicionar grupo de segurança e clique em Salvar.
1. Navegue de volta para a guia `EC2 Management Console`  e reconcte-se à instância `WebServer`.
    > Novamente, isso será registrado como um registro rejeitado, pois você não tem mais acesso SSH.
1. Navegue de volta para a guia EC2 Management Console.
1. Reverta o grupo de segurança da instância EC2 de volta para `PublicSG`:
    - Certifique-se de que a instância `WebServer` esteja selecionada e, em seguida, use o menu suspenso `Actions` para selecionar Security > `Change security groups`.
    - Na seção Grupos de segurança associados, clique em Remover à direita dos detalhes do grupo de segurança para remover o grupo `HTTPOnlySG`.
    - Use a barra de pesquisa na seção Grupos de segurança associados para selecionar o grupo de segurança `PublicSG`.
    - Clique em Adicionar grupo de segurança e clique em Salvar.
1. Navegue de volta para a guia CloudWatch Alarms e atualize os detalhes dos alarmes.
1. Você deve ver que o estado do alarme agora está em alarme. Se você anexou o alarme ao seu endereço de e-mail, deverá receber uma notificação sobre esse alarme.
    > Observação: Se o estado do alarme ainda mostrar Dados insuficientes, aguarde mais um ou dois momentos e atualize os detalhes dos alarmes novamente.

## Use o CloudWatch Logs Insights

1. No menu da barra lateral do CloudWatch, navegue até Logs e selecione **Logs Insights**.
1. Use a barra de pesquisa Selecionar grupo(s) de log para selecionar `VPCFlowLogs`.
1. No painel à direita, selecione Consultas.
1. Na seção `Sample queries`, expanda `VPC Flow Logs` e, em seguida, expanda os 20 principais endereços IP de origem com o maior número de solicitações rejeitadas.
1. Clique em Aplicar e observe as alterações aplicadas no editor de consultas.
1. Clique em Executar consulta.
    > Após alguns instantes, você verá alguns dados começarem a ser preenchidos.

## Analisar dados de logs de fluxo de VPC no Athena

### Criar a Tabela Athena

1. Navegue de volta para a guia do navegador S3 e, em seguida, navegue até `Buckets`.
1. Selecione o nome do bucket provisionado para abri-lo.
1. Selecione a pasta AWSLogs/ e continue abrindo as subpastas até chegar à pasta <DAY> que contém os logs.
1. No canto superior direito, clique em `Copy S3 URI`.
1. Cole o URI em um arquivo de texto, pois você precisará dele em breve.
1. Em uma nova guia do navegador, navegue até o **Athena**.
1. À direita, clique em `Launch query editor`.
1. Selecione a guia `Settings` e clique em `Manage`.
1. No campo `Location query results`, cole o URI do S3 copiado.
1. Clique em Salvar.

### Crie partições e analise os dados

1. Selecione `query editor` na guia `Editor`.
1. No editor `Query 1`, cole a seguinte consulta, substituindo `{your_log_bucket}` e `{account_id}` por seu depósito de log e detalhes de ID da conta (você pode obtê-los do caminho S3 URI que você copiou):
    ```
    CREATE EXTERNAL TABLE IF NOT EXISTS default.vpc_flow_logs (
    version int,
    account string,
    interfaceid string,
    sourceaddress string,
    destinationaddress string,
    sourceport int,
    destinationport int,
    protocol int,
    numpackets int,
    numbytes bigint,
    starttime int,
    endtime int,
    action string,
    logstatus string
    )
    PARTITIONED BY (dt string)
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ' '
    LOCATION 's3://{your_log_bucket}/AWSLogs/{account_id}/vpcflowlogs/us-east-1/'
    TBLPROPERTIES ("skip.header.line.count"="1");
    ```
1. Clique em `Run`.
    > Você deve ver uma mensagem indicando que a consulta foi bem-sucedida.
1. À direita, clique no ícone + para abrir um novo editor de consultas.
1. No editor, cole a seguinte consulta, substituindo {Year}-{Month}-{Day} pela data atual e substituindo o local existente pelo URI do S3 copiado:
    ```
    ALTER TABLE default.vpc_flow_logs
        ADD PARTITION (dt='{Year}-{Month}-{Day}')
        location 's3://{your_log_bucket}/AWSLogs/{account_id}/vpcflowlogs/us-east-1/{Year}/{Month}/{Day}/';
    ```
1. Clique em `Run`.
    > Você deve ver uma mensagem indicando que a consulta foi bem-sucedida.
1. À direita, clique no ícone + para abrir um novo editor de consultas.
1. No editor, cole a seguinte consulta:
    ```
    SELECT day_of_week(from_iso8601_timestamp(dt)) AS
        day,
        dt,
        interfaceid,
        sourceaddress,
        destinationport,
        action,
        protocol
    FROM vpc_flow_logs
    WHERE action = 'REJECT' AND protocol = 6
    order by sourceaddress
    LIMIT 100;
    ```
1. Clique em `Run`.
    > Seus dados particionados devem ser exibidos nos resultados da consulta.

## Encerrando recursos

- Apague os flow logs criados;
- Remova a policy adicionada ao bucket;
- Delete a stack;
    - Ao ser perguntando selecione para manter o bucket;