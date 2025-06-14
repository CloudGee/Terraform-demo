# 使用官方 Ubuntu 作为基础镜像
ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:2-${VARIANT}

# 安装基本依赖和 curl、unzip、git
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    git \
    ca-certificates \
    jq \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 动态获取 GitHub latest release 的版本号并下载对应 deb 包安装
RUN ARCH="amd64" \
    && LATEST_TAG=$(curl -s https://api.github.com/repos/opentofu/opentofu/releases/latest | jq -r '.tag_name') \
    && VERSION="${LATEST_TAG#v}" \
    && URL="https://github.com/opentofu/opentofu/releases/download/${LATEST_TAG}/tofu_${VERSION}_${ARCH}.deb" \
    && echo "Downloading $URL" \
    && curl -Lo /tmp/tofu.deb "$URL" \
    && dpkg -i /tmp/tofu.deb || apt-get install -f -y \
    && rm /tmp/tofu.deb

# 安装aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws

# 创建软链接 terraform -> opentofu，方便直接用 terraform 命令
RUN ln -s /usr/bin/tofu /usr/bin/terraform

USER vscode
RUN tofu -install-autocomplete && echo 'complete -C "/usr/local/bin/aws_completer" aws' >> ~/.zshrc