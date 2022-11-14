address CounterAccount {
    module counter {

        use std::signer;    // import signer library

        struct Counter has key {    // declaring a resource
            counter: u128   // declare the counter value
        }

        const SIGNER_NOT_COUNTER_ACCOUNT : u64 = 0; // declaring an error constant
        const COUNTER_NOT_INITIALIZED : u64 = 1;    // declaring an error constant
        const COUNTER_IS_INITIALIZED : u64 = 2;    // declaring an error constant

        public entry fun initialize(counterAccount: &signer) { 
            let counterAccountAddress = signer::address_of(counterAccount); // get the address of signer
            assert!(counterAccountAddress == @CounterAccount, SIGNER_NOT_COUNTER_ACCOUNT); // check that address is owner
            assert!(!exists<Counter>(@CounterAccount), COUNTER_IS_INITIALIZED);
            move_to<Counter>(       // write the resource Counter to storage
                counterAccount,     // the signer, where resource Counter will be written to signer storage
                Counter {           // resource Counter
                    counter : 0     // initial value 0
                }
            )
        }

        public entry fun increment(account: &signer) acquires Counter {
            account;
            assert!(exists<Counter>(@CounterAccount), COUNTER_NOT_INITIALIZED); // check that counter is initialized
            let counter_state = borrow_global_mut<Counter>(@CounterAccount);    // read the resource, that can be mutate
            counter_state.counter = counter_state.counter + 1;  // increase counter
        }

        public entry fun get_counter(): u128 acquires Counter {
            assert!(exists<Counter>(@CounterAccount), COUNTER_NOT_INITIALIZED); // check that counter is initialized
            borrow_global<Counter>(@CounterAccount).counter // return global conter value
        }

    }

}