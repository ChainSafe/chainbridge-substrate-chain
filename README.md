# chainbridge-substrate-chain

A simple substrate chain for testing and demo purposes.

This chain is based off the [Substrate Node Template](https://github.com/substrate-developer-hub/substrate-node-template) and includes `chainbridge` and `example-pallet` from [chainbridge-substrate](https://github.com/ChainSafe/chainbridge-substrate).

## Polkadot JS Apps

You can interact with a local node by visiting https://polkadot.js.org/apps/.

You will need to add these definitions to the developer settings:

```json
{
  "chainbridge::ChainId": "u8",
  "ChainId": "u8",
  "ResourceId": "[u8; 32]",
  "DepositNonce": "u64",
  "ProposalVotes": {
    "votes_for": "Vec<AccountId>",
    "votes_against": "Vec<AccountId>",
    "status": "enum"
  },
  "Erc721Token": {
    "id": "TokenId",
    "metadata": "Vec<u8>"
  },
  "TokenId": "U256",
  "Address": "AccountId",
  "LookupSource": "AccountId"
}
```

