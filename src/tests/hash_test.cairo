use cairo_transaction::hash::{
    compute_hash_on_elements, calculate_declare_transaction_hash, calculate_deploy_transaction_hash,
    calculate_transaction_hash
};
use core::array::ArrayTrait;
use starknet::contract_address_const;

#[test]
#[available_gas(24000)]
fn should_return_valid_hash_for_empty_array_test() {
    let empty_array: Array<felt252> = ArrayTrait::new();
    let res = compute_hash_on_elements(@empty_array);
    assert(
        res == 0x49ee3eba8c1600700ee1b87eb599f16716b0b1022947733551fde4050ca6804,
        'hash is not match'
    );
}

#[test]
#[available_gas(65000)]
fn should_return_valid_hash_for_valid_array_test() {
    let array_with_elements: Array<felt252> = array![123782376, 213984, 128763521321];
    let res = compute_hash_on_elements(@array_with_elements);
    assert(
        res == 0x7b422405da6571242dfc245a43de3b0fe695e7021c148b918cd9cdb462cac59,
        'hash is not match'
    );
}

#[test]
fn valid_declare_test() {
    let class_hash = 0x05228471e1b116deedf0c16f183fed4bc6cb48331c0352c826c6a9ab99404d03;
    let sender_address = contract_address_const::<
        0x00173fa12202cae01dcaf748d474189f8551d213883586c0f8a76c7b66995a6e
    >();
    let version = 2;
    let max_fee = 3701000029608;
    let chain_id = 'SN_GOERLI';
    let nonce = 4;
    let casm_class_hash = 0x018945d83e6fa54b9836808a085cf1568b5876e7091a2c5181ccdd32a902db9c;
    let tx_hash = calculate_declare_transaction_hash(
        class_hash, sender_address, version, max_fee, chain_id, nonce, casm_class_hash
    );
    assert(
        tx_hash == 0x04591dc6402444ae6aa42cbdd060f9d63d8eb59c95683eae58028dd8c2f17551,
        'hash is not match'
    );
}

#[test]
fn valid_deploy_test() {
    let class_hash = contract_address_const::<
        0x0593c65c3cb6df0dabe7807b6b63de4c9972868e5b4d185a000e18b00d06e826
    >();
    let calldata: Array<felt252> = ArrayTrait::new();
    let version = 2;
    let chain_id = 'SN_GOERLI';
    let tx_hash = calculate_deploy_transaction_hash(class_hash, @calldata, version, chain_id);
    assert(
        tx_hash == 0x23cde0eb305488c4c6ef2ffc2ddfd9b3f42d0aba3ce43de6a623c65890011a,
        'hash is not match'
    );
}

#[test]
fn valid_invoke_hash() {
    let contractAddress = contract_address_const::<
        0x000d5f442d503944feb934349600ce0b234efaf83760ddc42df89428bb4d0566
    >();
    let version = 1;
    let calldata = array![
        1,
        18784040408178839229378287456386991437336044790051748447507819446610775779,
        52545282147882418237597393020473878138626975305279993582974441178513951485,
        5,
        1,
        3,
        217543973298082113434261145621703900097673844055271269298739255648112419372,
        60876244043081946271198156722882189183426281997503066049123383873278849072,
        45422911109658608369993924078002512509
    ];
    let max_fee = 6000000132362;
    let chainId = 'SN_GOERLI';
    let nonce = 103;
    let tx_hash = calculate_transaction_hash(
        contractAddress, version, @calldata, max_fee, chainId, nonce
    );
    assert(
        tx_hash == 0xaad737f174da7a8f1df2fd727bcf7dfe93e078f198691ab24af57d8f860ec6,
        'hash is not match'
    );
}
