#!/bin/bash

# 启动 MySQL
service mysql start

# 启动 ZooKeeper
/path/in/final/image/zookeeper/bin/zkServer.sh start

# 启动 Hadoop
/path/in/final/image/hadoop/bin/start-dfs.sh
/path/in/final/image/hadoop/bin/start-yarn.sh

# 启动 Hive
/path/in/final/image/hive/bin/hive --service metastore &
/path/in/final/image/hive/bin/hive --service hiveserver2 &

# 保持容器运行
tail -f /dev/null
