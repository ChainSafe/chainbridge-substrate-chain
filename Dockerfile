# Adapted from github.com/centrifuge/centrifuge-chain

# Note: We don't use Alpine and its packaged Rust/Cargo because they're too often out of date,
# preventing them from being used to build Substrate/Polkadot.

FROM phusion/baseimage:0.10.2 as builder
LABEL maintainer="david@chainsafe.io"
LABEL description="This is the build stage for the node. Here the binary is created."

ENV DEBIAN_FRONTEND=noninteractive
ENV RUST_TOOLCHAIN=nightly-2020-08-16

ARG PROFILE=release
WORKDIR /chainbridge-substrate-chain

COPY . /chainbridge-substrate-chain

RUN apt-get update && \
	apt-get dist-upgrade -y -o Dpkg::Options::="--force-confold" && \
	apt-get install -y cmake pkg-config libssl-dev git clang

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
	export PATH="$PATH:$HOME/.cargo/bin" && \
	rustup toolchain install $RUST_TOOLCHAIN && \
	rustup target add wasm32-unknown-unknown --toolchain $RUST_TOOLCHAIN && \
	rustup default $RUST_TOOLCHAIN && \
	rustup default stable && \
	cargo build "--$PROFILE"

# ===== SECOND STAGE ======

FROM phusion/baseimage:0.10.2
LABEL maintainer="david@chainsafe.io"
LABEL description="This is the 2nd stage: a very small image that contains the chainbridge-substrate-chain binary and will be used by users."
ARG PROFILE=release

RUN mv /usr/share/ca* /tmp && \
	rm -rf /usr/share/*  && \
	mv /tmp/ca-certificates /usr/share/ && \
	mkdir -p /root/.local/share/chainbridge-substrate-chain && \
	ln -s /root/.local/share/chainbridge-substrate-chain /data

COPY --from=builder /chainbridge-substrate-chain/target/$PROFILE/chainbridge-substrate-chain /usr/local/bin

# checks
RUN ldd /usr/local/bin/chainbridge-substrate-chain && \
	/usr/local/bin/chainbridge-substrate-chain --version

# Shrinking
RUN rm -rf /usr/lib/python* && \
	rm -rf /usr/bin /usr/sbin /usr/share/man

## Add chain resources to image
#COPY res /resources/

# USER chainbridge-substrate-chain # see above
EXPOSE 30333 9933 9944
VOLUME ["/data"]

CMD ["/usr/local/bin/chainbridge-substrate-chain"]
