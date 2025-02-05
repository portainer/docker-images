FROM ubuntu:20.04

# Set TERM as noninteractive to suppress debconf errors
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install packages
RUN apt-get update && apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  netcat \
  software-properties-common

# Install Docker

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io


# probably a need to update /etc/docker/daemon.json


# Install kind

RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.16.0/kind-linux-amd64 && \
  chmod +x ./kind && \
  mv ./kind /usr/local/bin/kind

COPY kind.yaml /

# Install kubectl

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
  chmod +x ./kubectl && \
  mv ./kubectl /usr/local/bin/kubectl

# Install httpie and jq

RUN apt-get install -y httpie jq

# Install wait-for

RUN curl -L https://raw.githubusercontent.com/eficode/wait-for/master/wait-for -o /bin/wait-for && chmod +x /bin/wait-for
