# 使用 Ubuntu 作为基础镜像
FROM ubuntu:latest AS base

# 安装依赖
RUN apt-get update && apt-get install -y vim

# 第二阶段：集成 MySQL
FROM mysql:latest AS mysql-stage
# 在这里可以配置 MySQL

# 第三阶段：集成 ZooKeeper
FROM zookeeper:latest AS zookeeper-stage
# 在这里可以配置 ZooKeeper

# 第四阶段：集成 Hadoop
FROM apache/hadoop:3.3.6 AS hadoop-stage
# 在这里可以配置 Hadoop

# 第五阶段：集成 Hive
FROM apache/hive:4.0.0-beta-1 AS hive-stage
# 在这里可以配置 Hive

# 最终阶段：将所有服务整合到基础镜像中
FROM base
# 复制 MySQL 文件
COPY --from=mysql-stage /path/to/mysql /path/in/final/image/mysql
# 复制 Zookeeper 文件
COPY --from=zookeeper-stage /path/to/zookeeper /path/in/final/image/zookeeper
# 复制 Hadoop 文件
COPY --from=hadoop-stage /path/to/hadoop /path/in/final/image/hadoop
# 复制 Hive 文件
COPY --from=hive-stage /path/to/hive /path/in/final/image/hive

# 配置启动脚本
COPY start-services.sh /usr/local/bin/
CMD ["start-services.sh"]