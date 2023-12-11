#!/bin/bash


# 启动 ZooKeeper
$ZOOKEEPER_HOME/bin/zkServer.sh start

# 启动 Hadoop
$HADOOP_HOME/bin/hdfs namenode -format
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh

# 启动 Hive
$HIVE_HOME/bin/hive --service metastore &
$HIVE_HOME/bin/hive --service hiveserver2 &

# 保持容器运行
tail -f /dev/null

