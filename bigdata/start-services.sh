#!/bin/bash

# 启动 MySQL
service mysql start

# 启动 ZooKeeper
/zookeeper/bin/zkServer.sh start

# 启动 Hadoop
/hadoop/bin/start-dfs.sh
/hadoop/bin/start-yarn.sh

# 启动 Hive
/hive/bin/hive --service metastore &
/hive/bin/hive --service hiveserver2 &

# 保持容器运行
tail -f /dev/null
