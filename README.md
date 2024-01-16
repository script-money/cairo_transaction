# cairo transaction

## About

This library implements Starknet transactions using the Cairo language, has same API with [Starknet.js](https://github.com/starknet-io/starknet.js/blob/c0b4e67a28edcd131008fcee6ecc5f4a2c15e9b3/src/utils/hash.ts#L69). It is particularly useful when testing generating specific tx hashes in Cairo.

## Usage

[Example](https://github.com/script-money/cairo-bitwork/blob/517c016152d7dc5090dd9ae597e4b4e43bae6c74/tests/ins_test.cairo#L72)

In Scarb.toml

```
[dependencies]
cairo_transaction = { git = "https://github.com/script-money/cairo_transaction.git" }
```

In cairo

```cairo
use cairo_transaction::transaction::get_execute_call_data;
use cairo_transaction::hash::{
    compute_hash_on_elements, calculate_declare_transaction_hash, calculate_deploy_transaction_hash,
    calculate_transaction_hash
};
```
