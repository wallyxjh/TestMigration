# 使用 Ubuntu 作为基础镜像
FROM ubuntu:latest AS base

# 安装依赖
RUN apt-get update && apt-get install -y ...

# 第二阶段：集成 MySQL
FROM mysql:latest AS mysql-stage
# 在这里可以配置 MySQL

# 第三阶段：集成 ZooKeeper
FROM zookeeper:latest AS zookeeper-stage
# 在这里可以配置 ZooKeeper

# 第四阶段：集成 Hadoop
FROM your-hadoop-image AS hadoop-stage
# 在这里可以配置 Hadoop

# 第五阶段：集成 Hive
FROM your-hive-image AS hive-stage
# 在这里可以配置 Hive

# 最终阶段：将所有服务整合到基础镜像中
FROM base
COPY --from=mysql-stage /path/in/mysql /path/in/ubuntu
COPY --from=zookeeper-stage /path/in/zookeeper /path/in/ubuntu
COPY --from=hadoop-stage /path/in/hadoop /path/in/ubuntu
COPY --from=hive-stage /path/in/hive /path/in/ubuntu

# 配置启动脚本
COPY start-services.sh /usr/local/bin/
CMD ["start-services.sh"]