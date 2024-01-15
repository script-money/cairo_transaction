use cairo_transaction::hash::compute_hash_on_elements;
use core::array::ArrayTrait;

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

