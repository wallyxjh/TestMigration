# 使用基础镜像
FROM ubuntu:latest

# 安装依赖
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    wget \
    ssh \
    pdsh \
    && rm -rf /var/lib/apt/lists/*

ENV HADOOP_HOME /usr/local/hadoop
ENV HIVE_HOME /usr/local/hive
ENV ZOOKEEPER_HOME /usr/local/zookeeper
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin:$ZOOKEEPER_HOME/bin

## 安装 MySQL
#RUN wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.19-linux-glibc2.12-x86_64.tar.xz
#RUN tar -xJf mysql-8.0.19-linux-glibc2.12-x86_64.tar.xz -C /usr/local/
#RUN mv /usr/local/mysql-8.0.19-linux-glibc2.12-x86_64 $MYSQL_HOME
#RUN rm mysql-8.0.19-linux-glibc2.12-x86_64.tar.xz

# 安装 ZooKeeper
RUN wget https://downloads.apache.org/zookeeper/zookeeper-3.7.2/apache-zookeeper-3.7.2-bin.tar.gz
RUN tar -xzf apache-zookeeper-3.7.2-bin.tar.gz -C /usr/local/
RUN mv /usr/local/apache-zookeeper-3.7.2-bin $ZOOKEEPER_HOME
RUN rm apache-zookeeper-3.7.2-bin.tar.gz

# 安装 Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-3.2.4/hadoop-3.2.4.tar.gz
RUN tar -xzf hadoop-3.2.4.tar.gz -C /usr/local/
RUN mv /usr/local/hadoop-3.2.4 $HADOOP_HOME
RUN rm hadoop-3.2.4.tar.gz

# 安装 Hive
RUN wget https://downloads.apache.org/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz
RUN tar -xzf apache-hive-3.1.2-bin.tar.gz -C /usr/local/
RUN mv /usr/local/apache-hive-3.1.2-bin $HIVE_HOME
RUN rm apache-hive-3.1.2-bin.tar.gz

# 配置文件和启动脚本 (这里需要你自己提供)
COPY mysql-config.cnf $MYSQL_HOME/my.cnf
COPY zookeeper-config.cfg $ZOOKEEPER_HOME/conf/zoo.cfg
COPY hadoop-config/* $HADOOP_HOME/etc/hadoop/
COPY hive-config/* $HIVE_HOME/conf/
COPY start-services.sh /usr/local/bin/

# 开放端口 (根据需要调整)
EXPOSE 3306 2181 9870 8088 10000

# 启动命令
#CMD ["start-services.sh"]