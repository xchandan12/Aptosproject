module PetRegistry::Tracking {

    use aptos_framework::signer;
    use aptos_framework::aptos_account;

    struct Pet has store, key {
        owner: address,
        name: vector<u8>,
        medical_history: vector<u8>,
    }

    // Function to register a new pet with a name and medical history
    public fun register_pet(account: &signer, name: vector<u8>, medical_history: vector<u8>) {
        let owner = signer::address_of(account);
        let pet = Pet { owner, name, medical_history };
        move_to(account, pet);
    }

    // Function to update the pet's information, including owner transfer or medical history update
    public fun update_pet(account: &signer, new_owner: address, new_medical_history: vector<u8>) acquires Pet {
        let pet = borrow_global_mut<Pet>(signer::address_of(account));
        
        // Update owner and medical history
        pet.owner = new_owner;
        pet.medical_history = new_medical_history;
    }
}
