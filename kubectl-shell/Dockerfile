ARG ALPINE=alpine:latest
FROM ${ALPINE} AS alpine
ARG TARGETARCH
ARG KUBECTL_VERSION=v1.31.0
ARG HELM_VERSION=v3.15.4

RUN apk add -U --no-cache bash bash-completion curl jq

# Kubectl CLI
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    echo -e 'source /usr/share/bash-completion/bash_completion\nsource <(kubectl completion bash)' >>~/.bashrc

# Helm
RUN curl -L https://get.helm.sh/helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz | tar xvzf - && \
    mv ./linux-${TARGETARCH}/helm . && \
    chmod +x ./helm && \
    mv ./helm /usr/local/bin/helm

# Linux user permissions
RUN echo 'shell:x:1000:1000:shell,,,:/home/shell:/bin/bash' > /etc/passwd && \
    echo 'shell:x:1000:' > /etc/group && \
    mkdir /home/shell && \
    echo '. /etc/bash/bash_completion.sh' >> /home/shell/.bashrc && \
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
