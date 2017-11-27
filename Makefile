RELEASE=sandbox
HELM=bin/helm
HELM_VERSION=2.7.2
MINIKUBE_VERSION=0.23.0
ROOT=$(shell pwd)

init: 
	helm init 

lint:
	@echo 'Linting'
	@echo '-------'
	@find charts -maxdepth 1 -mindepth 1 -type d -not -name '.*' -exec bash -c 'echo {} && pushd {} && $(ROOT)/$(HELM) lint' \;
	@echo ''

test:
	@echo 'Dry running'
	@echo '-------'
	@find charts -maxdepth 1 -mindepth 1 -type d -not -name '.*' | xargs -t -0 $(ROOT)/$(HELM) install --dry-run --debug  > /dev/null
	@echo ''

install:
	@echo 'Installing'
	@echo '-------'
	@find charts -maxdepth 1 -mindepth 1 -type d -not -name '.*' | xargs -t -0 $(ROOT)/$(HELM) upgrade $(RELEASE) -i --wait > /dev/null
	@echo ''

init_bin:
	@mkdir bin || true
	@echo 'Download Minikube Binary'
	@curl -Lo $(ROOT)/bin/minikube https://storage.googleapis.com/minikube/releases/v$(MINIKUBE_VERSION)/minikube-linux-amd64 \
		&& chmod +x $(ROOT)/bin/minikube
	@echo ''
	@echo 'Downoad Helm Binary'
	@curl -Lo $(ROOT)/bin/helm.tgz https://storage.googleapis.com/kubernetes-helm/helm-v$(HELM_VERSION)-linux-amd64.tar.gz \
		&& tar  -C $(ROOT)/bin --strip=1 -xvzf $(ROOT)/bin/helm.tgz linux-amd64/helm \
		&& chmod +x $(ROOT)/bin/helm \
		&& rm $(ROOT)/bin/helm.tgz
