# 使用官方的CockroachDB基础镜像
FROM cockroachdb/cockroach:v21.1.7

# 设置工作目录
WORKDIR /cockroach

# 暴露CockroachDB默认端口
EXPOSE 26257 8080

# 设置启动时运行的命令
ENTRYPOINT ["/cockroach/cockroach"]
