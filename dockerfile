FROM ubuntu:22.04

WORKDIR /app

ARG TOKEN

# Install wget
RUN apt update && apt install -y && apt install -y wget

# Exercism CLI
RUN wget "https://github.com/exercism/cli/releases/download/v3.5.4/exercism-3.5.4-linux-x86_64.tar.gz" 
RUN tar -xf exercism-3.5.4-linux-x86_64.tar.gz exercism && rm exercism-3.5.4-linux-x86_64.tar.gz
RUN mkdir bin && mv exercism bin
ENV PATH="/app/bin:${PATH}"

# Golang tooling
RUN wget "https://go.dev/dl/go1.24.3.linux-amd64.tar.gz"
RUN tar -xf go1.24.3.linux-amd64.tar.gz && rm go1.24.3.linux-amd64.tar.gz
ENV PATH="/app/go/bin:${PATH}"

# First exercise
RUN /app/bin/exercism configure --token=${TOKEN}
RUN exercism download --track=go --exercise=hello-world

WORKDIR /root/exercism/go

CMD ["/bin/bash"]