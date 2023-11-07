# Confiabilidade e Continuidade de Negócios

A confiabilidade e continuidade de sistema em ambientes Cloud são essenciais para garantir a disponibilidade e o funcionamento ininterrupto das aplicações e serviços hospedados na nuvem. Diversas ferramentas e serviços da AWS contribuem para alcançar esse objetivo.

- O uso de **Auto Scaling Plans permite** que as aplicações se adaptem automaticamente às demandas variáveis de tráfego, ajustando a capacidade da infraestrutura de forma elástica.
- O **Amazon EFS (Elastic File System)** possibilita o armazenamento de dados compartilhado e escalável, garantindo que as aplicações tenham acesso consistente aos arquivos, contribuindo para a confiabilidade dos sistemas.
- O **RDS (Relational Database Service)** e o **Aurora** fornecem alta disponibilidade e escalabilidade para bancos de dados, permitindo que os aplicativos mantenham o acesso contínuo a informações críticas, mesmo em caso de falhas de hardware ou aumento repentino na demanda. 
- O **AWS Backup** simplifica a proteção e recuperação de dados, permitindo a criação de políticas de backup automatizadas para diversos serviços AWS, mitigando riscos de perda de informações críticas.
- O **Amazon S3 (Simple Storage Service)** oferece um repositório seguro e altamente durável para armazenar dados e backups, assegurando a continuidade das operações mesmo diante de possíveis falhas de hardware.

Ao dominar essas ferramentas, o profissional certificado AWS SysOps Administrator estará apto a projetar e gerenciar sistemas altamente confiáveis e resilientes na nuvem da Amazon Web Services.

## Referencias

### Elasticidade X Escalabilidade

- https://wa.aws.amazon.com/wellarchitected/2020-07-02T19-33-23/wat.concept.elasticity.en.html
- https://wa.aws.amazon.com/wellarchitected/2020-07-02T19-33-23/wat.concept.scalability.en.html
- https://wa.aws.amazon.com/wellarchitected/2020-07-02T19-33-23/wat.concept.horizontal-scaling.en.html
- https://www.cloudzero.com/blog/horizontal-vs-vertical-scaling
- https://medium.com/@khushalbisht/aws-scaling-horizontally-vs-vertically-3e30e3e71118
- https://docs.aws.amazon.com/whitepapers/latest/real-time-communication-on-aws/high-availability-and-scalability-on-aws.html
- https://aws.amazon.com/blogs/startups/how-to-get-high-availability-in-architecture/
- https://repost.aws/knowledge-center/auto-scaling-troubleshooting
- https://docs.aws.amazon.com/autoscaling/plans/userguide/best-practices-for-scaling-plans.html

### AutoScaling

- https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html
- https://aws.amazon.com/autoscaling/features/
- https://docs.aws.amazon.com/autoscaling/plans/userguide/what-is-a-scaling-plan.html
- https://docs.aws.amazon.com/autoscaling/plans/userguide/best-practices-for-scaling-plans.html
- 

### EFS

- https://docs.aws.amazon.com/efs/latest/ug/whatisefs.html
- https://docs.aws.amazon.com/efs/latest/ug/how-it-works.html
- https://aws.amazon.com/solutions/partners/confluence/
- https://docs.aws.amazon.com/efs/latest/ug/security-considerations.html
- https://docs.aws.amazon.com/efs/latest/ug/storage-classes.html
- https://docs.aws.amazon.com/efs/latest/ug/storage-classes.html#sc-compare
- https://docs.aws.amazon.com/efs/latest/ug/performance.html#performance-overview
- https://docs.aws.amazon.com/efs/latest/ug/installing-amazon-efs-utils.html
- https://docs.aws.amazon.com/efs/latest/ug/automount-with-efs-mount-helper.html
- https://docs.aws.amazon.com/efs/latest/ug/efs-access-points.html

### Aurora

- https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html
- https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Overview.html
- https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.AuroraHighAvailability.html
- https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Replication.html
- https://zacks.one/aws-aurora/
- https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Overview.StorageReliability.html
- https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Managing.VolumeStatus.html
- https://docs.aws.amazon.com/prescriptive-guidance/latest/aurora-replication-options/introduction.html
- https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_Tutorials.html
- https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_DeleteCluster.html#USER_DeleteCluster.DeleteCluster
- https://pt.cyberaxe.org/article/what-is-the-difference-between-aws-aurora-and-mysql

### RDS

- https://aws.amazon.com/pt/rds/
- https://docs.aws.amazon.com/pt_br/AmazonRDS/latest/UserGuide/Welcome.html
- https://aws.amazon.com/rds/features/multi-az/?nc1=h_ls
- https://aws.amazon.com/rds/features/read-replicas/?nc1=h_ls
- https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZSingleStandby.html
- https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RDS_Fea_Regions_DB-eng.Feature.MultiAZDBClusters.html
- https://medium.com/awesome-cloud/aws-difference-between-multi-az-and-read-replicas-in-amazon-rds-60fe848ef53a
- https://dev.to/aws-heroes/multi-az-in-amazon-rds-and-how-it-differs-from-high-availability-gn9
- https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReadRepl.html
- https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReadRepl.html#USER_ReadRepl.Overview.Differences

### Backup/Recovery

- https://wa.aws.amazon.com/wellarchitected/2020-07-02T19-33-23/wat.concept.availability.en.html
- https://docs.aws.amazon.com/pdfs/whitepapers/latest/disaster-recovery-workloads-on-aws/disaster-recovery-workloads-on-aws.pdf

#### EBS Snapshots

- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html#vol-type-ssd
- https://aws.amazon.com/about-aws/whats-new/2020/12/introducing-new-amazon-ebs-general-purpose-volumes-gp3/
- https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html
- https://docs.aws.amazon.com/whitepapers/latest/establishing-your-cloud-foundation-on-aws/choosing-tags.html
- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/snapshot-lifecycle.html

#### AWS Backup

- https://docs.aws.amazon.com/pt_br/aws-backup/latest/devguide/whatisbackup.html
- https://aws.amazon.com/backup/?nc=sn&loc=1
- https://aws.amazon.com/backup/faqs/
- https://docs.aws.amazon.com/aws-backup/latest/devguide/vaults.html
