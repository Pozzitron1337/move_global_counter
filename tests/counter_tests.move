#[test_only]
module CounterAccount::counter_test {

    use CounterAccount::counter;

    #[test]
    #[expected_failure(abort_code = 1)]
    public entry fun test_get_counter_failed() {
        counter::get_counter();
    }

    #[test(counterAccount=@CounterAccount)]
    public entry fun test_initialize(counterAccount: &signer) {
        
        counter::initialize(counterAccount);
        let actual_result = counter::get_counter();
        let expected_result: u128 = 0u128;
        assert!(actual_result == expected_result, 123)
    }

    #[test(counterAccount=@CounterAccount)]
    public entry fun test_increment(counterAccount: &signer) {
        counter::initialize(counterAccount);
        let counter_before = counter::get_counter();
        counter::increment(counterAccount);
        let counter_after = counter::get_counter();
        assert!(counter_after == counter_before + 1, 123)
    }

    #[test(counterAccount=@CounterAccount, user=@0xCAFEBABE)]
    public entry fun test_increment_from_user(counterAccount: &signer, user: &signer) {
        counter::initialize(counterAccount);
        let counter_before = counter::get_counter();
        counter::increment(user);
        let counter_after = counter::get_counter();
        assert!(counter_after == counter_before + 1, 123)
    }

    


}