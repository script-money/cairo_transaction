use starknet::{contract_address_to_felt252, account::Call};

fn get_execute_call_data(mut calls: Array<Call>) -> Array<felt252> {
    let mut result: Array<felt252> = ArrayTrait::new();
    result.append(calls.len().into());
    loop {
        match calls.pop_front() {
            Option::Some(mut call) => {
                result.append(contract_address_to_felt252(call.to));
                result.append(call.selector);
                result.append(call.calldata.len().into());
                let mut j = 0;
                loop {
                    if j == call.calldata.len() {
                        break;
                    }
                    result.append(*call.calldata.at(j));
                    j += 1;
                };
            },
            Option::None => { break; },
        };
    };
    result
}
