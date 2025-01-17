FROM    alpine
RUN     apk add --update --no-cache curl git \
        && addgroup -g 3000 k8s4u \
        && adduser -u 1000 -G k8s4u -S -H k8s4u \
        && mkdir -p /home/k8s4u/ \
        && chown 1000:3000 /home/k8s4u/ -R

RUN     curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
        && curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" \
        && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
        && rm kubectl kubectl.sha256

COPY    /k8s4u-gitops-agent /k8s4u-gitops-agent
COPY    /scripts /scripts
ENTRYPOINT [ "/k8s4u-gitops-agent" ]
