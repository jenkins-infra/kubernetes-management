FROM alpine

LABEL \
  maintainer="https://github.com/olblak" \
  repository="https://github.com/jenkins-infra/charts"

ENV HELM_HOME="/home/helm/.helm"

RUN \
  apk add --no-cache gnupg wget ca-certificates git bash curl

# Install kubectl
ENV HELM_VERSION=v2.16.7
ENV HELM_LOCATION="https://kubernetes-helm.storage.googleapis.com"
ENV HELM_FILENAME="helm-${HELM_VERSION}-linux-amd64.tar.gz"
ENV HELM_SHA256="4afe48da420e4c3adcccf8484f27991834e3a3838668103199f274f4fa6f2df2"
RUN wget ${HELM_LOCATION}/${HELM_FILENAME} && \
    sha256sum ${HELM_FILENAME} | grep -q "${HELM_SHA256}" && \
    tar zxf ${HELM_FILENAME} && mv /linux-amd64/helm /usr/local/bin/ && \
    rm ${HELM_FILENAME} && rm -r /linux-amd64

# Install helm
ENV KUBECTL_VERSION="v1.14.5"
ENV KUBECTL_SHA256="26681319de56820a8467c9407e9203d5b15fb010ffc75ac5b99c9945ad0bd28c"
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    sha256sum kubectl | grep ${KUBECTL_SHA256} && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl

# Instal sops
ENV SOPS_VERSION="3.4.0"
RUN \
  wget https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux -O /usr/local/bin/sops && \
  chmod +x /usr/local/bin/sops

# Instal helmfile
ENV HELMFILE_VERSION="0.90.0"
RUN \
  wget https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 -O /usr/local/bin/helmfile && \
  chmod +x /usr/local/bin/helmfile

RUN adduser -D -u 1000 helm

USER helm

WORKDIR /home/helm

RUN \
  helm init --client-only && \
  helm plugin install https://github.com/databus23/helm-diff && \
  helm plugin install https://github.com/futuresimple/helm-secrets && \
  helm plugin install https://github.com/aslafy-z/helm-git.git && \
  helm plugin install https://github.com/rimusz/helm-tiller

ENTRYPOINT "/usr/local/bin/helmfile"
