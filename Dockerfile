FROM python:3.10-slim

WORKDIR /app

# 安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# 设置默认环境变量
ENV PORT=3700 \
    TIMEOUT=120 \
    PROXY="" \
    POE_API_KEY="" \
    ACCESS_TOKEN=""

# 复制应用代码
COPY app.py .
COPY config.example.toml /app/config.template.toml
RUN echo '#!/bin/sh\n\
envsubst < /app/config.template.toml > /app/config.toml\n\
exec "$@"' > /app/docker-entrypoint.sh && \
    chmod +x /app/docker-entrypoint.sh

# 暴露端口
EXPOSE 3700

# 启动应用
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["python", "app.py"]