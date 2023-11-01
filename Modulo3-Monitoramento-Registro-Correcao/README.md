# Monitoramento, registro e correção

O processo de monitoramento, registro e remediação em ambientes AWS é essencial para garantir a operação contínua, a segurança e a eficiência dos recursos na nuvem. Um AWS SysOps Administrator utiliza uma variedade de ferramentas para alcançar esse objetivo:

- O **Amazon CloudWatch** é uma das principais ferramentas de monitoramento, permitindo a coleta de métricas e logs para análise e alertas em tempo real.
- O **AWS CloudTrail** registra todas as atividades realizadas na conta, oferecendo uma trilha de auditoria detalhada para fins de segurança e conformidade.
- O **AWS Config** auxilia no registro do estado dos recursos e na avaliação do cumprimento das regras de configuração.

Com o uso integrado dessas ferramentas, o SysOps Administrator pode garantir a estabilidade, segurança e desempenho ideais da infraestrutura na AWS.

## Referências

### Health Dashborads

- https://health.aws.amazon.com/health/status

### Cloud Trail

- https://aws.amazon.com/pt/cloudtrail/
- https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html
- https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-concepts.html
- https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-aws-service-specific-topics.html#cloudtrail-aws-service-specific-topics-list
- https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-log-file-examples.html

### Athena

- https://docs.aws.amazon.com/athena/latest/ug/when-should-i-use-ate.html
- https://docs.aws.amazon.com/athena/latest/ug/querying-aws-service-logs.html
- https://docs.aws.amazon.com/athena/latest/ug/cloudtrail-logs.html

### Cloud Watch

- https://docs.aws.amazon.com/pt_br/AmazonCloudWatch/latest/monitoring/cloudwatch_architecture.html
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
- https://aws.amazon.com/cloudwatch/faqs/#:~:text=The%20minimum%20resolution%20supported%20by,minute%20or%20five%2Dminute%20intervals.
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/viewing_metrics_with_cloudwatch.html
- https://docs.aws.amazon.com/prescriptive-guidance/latest/implementing-logging-monitoring-cloudwatch/system-level-cloudwatch-configuration.html#system-level-metrics
- https://aws.amazon.com/about-aws/whats-new/2016/11/cloudwatch-extends-metrics-retention-and-new-user-interface/
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogsConcepts.html
- https://repost.aws/pt/knowledge-center/cloudwatch-logs-analyze
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Install-CloudWatch-Agent.html
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/UseCloudWatchUnifiedAgent.html
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/MonitoringLogData.html
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax-examples.html
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/US_SetupSNS.html
- https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ConsoleAlarms.html

### AWS Config

- https://docs.aws.amazon.com/config/latest/developerguide/WhatIsConfig.html
- https://blog.awsfundamentals.com/an-introduction-to-aws-config#heading-aws-config-overview
- https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html
- https://docs.aws.amazon.com/config/latest/developerguide/conformancepack-sample-templates.html
- https://docs.aws.amazon.com/config/latest/developerguide/remediation.html
- https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-automation.html
- https://docs.aws.amazon.com/systems-manager/latest/userguide/automation-setup-iam.html
- https://aws.amazon.com/config/faqs/
- https://repost.aws/questions/QUbzk1cn5jTr6vSc3FyGBkPw/help-how-do-you-turn-off-aws-config

### VPC Logs

- https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html
- https://aws.plainenglish.io/detailed-understanding-of-vpc-flow-logs-821a5acd75af
- https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-records-examples.html
- https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-cwl.html#flow-logs-iam
