# 使用基础镜像
FROM openjdk:8-jdk

# 设置环境变量
ENV MYSQL_VERSION 8.0.19
ENV ZOOKEEPER_VERSION 3.6.1
ENV HADOOP_VERSION 3.2.1
ENV HIVE_VERSION 3.1.2

ENV HADOOP_HOME /usr/local/hadoop
ENV HIVE_HOME /usr/local/hive
ENV MYSQL_HOME /usr/local/mysql
ENV ZOOKEEPER_HOME /usr/local/zookeeper

ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin:$MYSQL_HOME/bin:$ZOOKEEPER_HOME/bin

# 更新系统并安装必要的库
RUN apt-get update && apt-get install -y wget procps

# 安装 MySQL
RUN wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-${MYSQL_VERSION}-linux-glibc2.12-x86_64.tar.xz
RUN tar -xJf mysql-${MYSQL_VERSION}-linux-glibc2.12-x86_64.tar.xz -C /usr/local/
RUN mv /usr/local/mysql-${MYSQL_VERSION}-linux-glibc2.12-x86_64 $MYSQL_HOME
RUN rm mysql-${MYSQL_VERSION}-linux-glibc2.12-x86_64.tar.xz

# 安装 ZooKeeper
RUN wget https://downloads.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz
RUN tar -xzf apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz -C /usr/local/
RUN mv /usr/local/apache-zookeeper-${ZOOKEEPER_VERSION}-bin $ZOOKEEPER_HOME
RUN rm apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz

# 安装 Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
RUN tar -xzf hadoop-${HADOOP_VERSION}.tar.gz -C /usr/local/
RUN mv /usr/local/hadoop-${HADOOP_VERSION} $HADOOP_HOME
RUN rm hadoop-${HADOOP_VERSION}.tar.gz

# 安装 Hive
RUN wget https://downloads.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz
RUN tar -xzf apache-hive-${HIVE_VERSION}-bin.tar.gz -C /usr/local/
RUN mv /usr/local/apache-hive-${HIVE_VERSION}-bin $HIVE_HOME
RUN rm apache-hive-${HIVE_VERSION}-bin.tar.gz

# 配置文件和启动脚本 (这里需要你自己提供)
# COPY mysql-config.cnf $MYSQL_HOME/my.cnf
# COPY zookeeper-config.cfg $ZOOKEEPER_HOME/conf/zoo.cfg
# COPY hadoop-config/* $HADOOP_HOME/etc/hadoop/
# COPY hive-config/* $HIVE_HOME/conf/
# COPY start-services.sh /usr/local/bin/

# 开放端口 (根据需要调整)
EXPOSE 3306 2181 9870 8088 10000

# 启动命令
CMD ["start-services.sh"]

