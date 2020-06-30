#!/usr/bin/env bash

set -eux

RUST_TOOLCHAIN="${RUST_TOOLCHAIN:-nightly}"

# Enable warnings about unused extern crates
export RUSTFLAGS=" -W unused-extern-crates"

# Install rustup and the specified rust toolchain.
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
rustup toolchain install $RUST_TOOLCHAIN --allow-downgrade --profile minimal --component clippy

# Load cargo environment. Specifically, put cargo into PATH.
source ~/.cargo/env

sudo apt-get -y update
sudo apt-get install -y cmake pkg-config libssl-dev

rustup target add wasm32-unknown-unknown --toolchain $RUST_TOOLCHAIN

rustc --version
rustup --version
cargo --version

case $TARGET in
	"build-client")
		cargo build --release --locked "$@"
		;;

	"runtime-test")
		cargo test -p chainbridge-substrate-chain
		;;
esac
