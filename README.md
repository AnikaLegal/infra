- add database backup script
- add file backup script
- add database restore script
- add S3 file storage backend
- deploy to Anika AWS (document EC2 + S3 sizes + billing)

# Credstash

# Cost

Credits expire August 2021 = 20 months = $500 / mo or $500 / year

EC2 t2.medium \$750 pa

RDS db.t3.small $700
RDS         db.t3.micro     $350pa

Fargate t2.medium eq. $1500pa (4 x (0.5vCPU + 1GB)
ECS on EC2  t2.medium       $750 pa
ALB - \$320 pa

Current costs \$750 pa
Potential costs = 350 + 750 + 700 = 1750 pa

# References

- https://www.terraform.io/docs/providers/aws/index.html
