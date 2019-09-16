FROM quay.io/roboll/helmfile:v0.85.0

LABEL \
  maintainer="https://github.com/olblak" \
  repository="https://github.com/jenkins-infra/charts"

RUN \
  wget https://github.com/mozilla/sops/releases/download/3.4.0/sops-3.4.0.linux -O /usr/local/bin/sops && \
  chmod +x /usr/local/bin/sops

RUN adduser -D -u 1000 helmfile

USER helmfile

WORKDIR /home/helmfile

RUN helm init --client-only
