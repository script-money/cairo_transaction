use core::pedersen::{pedersen, PedersenTrait};
use core::hash::HashStateTrait;
use starknet::{contract_address_to_felt252, ContractAddress};

fn compute_hash_on_elements(data: @Array<felt252>) -> felt252 {
    let mut state = PedersenTrait::new(0);
    let mut i = 0;
    loop {
        if i == data.len() {
            break;
        }
        state = state.update(*data.at(i));
        i += 1;
    };
    state.update(i.into()).finalize()
}

fn calculate_transaction_hash_common(
    tx_hash_prefix: felt252,
    version: felt252,
    contract_address: ContractAddress,
    entry_point_selector: felt252,
    calldata: @Array<felt252>,
    max_fee: felt252,
    chain_id: felt252,
    additional_data: Array<felt252>
) -> felt252 {
    let calldata_hash = compute_hash_on_elements(calldata);
    let mut dataToHash = array![
        tx_hash_prefix,
        version,
        contract_address_to_felt252(contract_address),
        entry_point_selector,
        calldata_hash,
        max_fee,
        chain_id
    ];
    let mut i = 0;
    loop {
        if i == additional_data.len() {
            break;
        }
        dataToHash.append(*additional_data.at(i));
        i += 1;
    };
    let tx_hash = compute_hash_on_elements(@dataToHash);
    tx_hash
}

fn compute_transaction_hash(
    contractAddress: ContractAddress,
    version: felt252,
    calldata: @Array<felt252>,
    maxFee: felt252,
    chainId: felt252,
    nonce: felt252
) -> felt252 {
    let tx_hash = calculate_transaction_hash_common(
        'invoke', version, contractAddress, 0, calldata, maxFee, chainId, array![nonce]
    );
    tx_hash
}
