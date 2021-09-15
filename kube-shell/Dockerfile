ARG ALPINE=alpine:latest
FROM ${ALPINE} as alpine
ARG ARCH

RUN apk add -U --no-cache bash bash-completion curl jq

# Kubectl CLI
ARG KUBECTL_VERSION=v1.21.1
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    echo -e 'source /usr/share/bash-completion/bash_completion\nsource <(kubectl completion bash)' >>~/.bashrc

# Helm
ARG HELM_VERSION=v3.6.0
RUN curl -L https://get.helm.sh/helm-${HELM_VERSION}-linux-${ARCH}.tar.gz | tar xvzf - && \
    mv ./linux-${ARCH}/helm . && \
    chmod +x ./helm && \
    mv ./helm /usr/local/bin/helm

# K9s CLI
# ARG K9S_VERSION=v0.24.10
# RUN if [ "${ARCH}" = "amd64" ]; then ARCH=x86_64; fi && \
#     curl -L https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_${K9S_VERSION}_Linux_${ARCH}.tar.gz | tar xvzf - && \
#     chmod +x ./k9s && \
#     mv ./k9s /usr/local/bin/k9s

# Linux user permissions
RUN echo 'shell:x:1000:1000:shell,,,:/home/shell:/bin/bash' > /etc/passwd && \
    echo 'shell:x:1000:' > /etc/group && \
    mkdir /home/shell && \
    echo '. /etc/profile.d/bash_completion.sh' >> /home/shell/.bashrc && \
    echo 'alias kubectl="kubectl -n default"' >> /home/shell/.bashrc && \
    echo 'alias k="kubectl"' >> /home/shell/.bashrc && \
    echo 'alias ks="kubectl -n kube-system"' >> /home/shell/.bashrc && \
    echo 'source <(kubectl completion bash)' >> /home/shell/.bashrc && \
    echo 'PS1="> "' >> /home/shell/.bashrc && \
    chown -R shell /home/shell

# CMD file
RUN echo $'#!/bin/bash\n\
echo \n\
echo "# Run kubectl commands inside here" \n\
echo "# e.g. kubectl get all" \n\
export TERM=screen-256color \n\
exec bash' >> /usr/local/bin/welcome && \
    chmod +x /usr/local/bin/welcome

USER 1000
WORKDIR /home/shell

CMD ["welcome"]
