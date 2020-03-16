//! Substrate Node Template CLI library.
#![warn(missing_docs)]

mod chain_spec;
#[macro_use]
mod service;
mod cli;
mod command;

fn main() -> sc_cli::Result<()> {
	let version = sc_cli::VersionInfo {
		name: "Substrate Node",
		commit: env!("VERGEN_SHA_SHORT"),
		version: env!("CARGO_PKG_VERSION"),
		executable_name: "example-chain",
		author: "David Ansermino (ChainSafe)",
		description: "Example substrate chain with bridge functionality",
		support_url: "n/a",
		copyright_start_year: 2020,
	};

	command::run(version)
}
