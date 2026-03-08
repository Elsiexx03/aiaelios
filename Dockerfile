FROM python:3.12-slim

# 安装系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制整个项目
COPY . .

# 安装 Python 依赖
RUN cd saki-gateway && pip install --no-cache-dir -e . && \
    pip install --no-cache-dir lark-oapi

# 设置环境变量
ENV PYTHONPATH=/app/saki-gateway/src
ENV SAKI_HOST=0.0.0.0
ENV SAKI_PORT=3457

# 暴露端口
EXPOSE 3457

# 设置工作目录为网关目录
WORKDIR /app/saki-gateway

# 启动命令
CMD ["python3", "-m", "saki_gateway"]
