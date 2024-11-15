import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";

actor PhoneBook {
    type Contact = {
        name : Text;
        phoneNumber : Text;
    };

    var phoneBook = HashMap.HashMap<Nat, Contact>(1, Nat.equal, Hash.hash);

    // Instantiate the Id Counter
    var contactId : Nat = 1;


    // Create a function to add a New Contact
    public func addContact(contact : Contact) : async () {

        // Create Id counter
        let id : Nat = contactId;
        contactId += 1;

        // Create the contact
        phoneBook.put(id, contact);
    };


    // Create a function to retrieve a phone number from id
    public func retrievedetails(id : Nat) : async ?Contact {

        // Query Data
        let contactExist : ?Contact = phoneBook.get(id);

        // Return Contact
        contactExist;
    };


    // Create a function to update Contact name and Phone Number
    public func updateNumber(id : Nat, contact:Contact) : async Text {
        // Query Data
        let contactExist : ?Contact = phoneBook.get(id);

        // Validata if contaact exist
        switch(contactExist) {
            // case 1: If Contact does not exist
            case (null) {
                "Input a Valid ID, Contact does not exist";
            };

            // case2: if contact exist
            case(?numberUpdate) {
                // Updating Phone Number
                let numberUpdate: Contact = {
                    name = contact.name;
                    phoneNumber = contact.phoneNumber;
                };

                 // Update Contact
                phoneBook.put(id, numberUpdate);

                // Return Contact
                return "Number Updated successfully"
            };
        };

       

        
    };


    // Create a function to delete Contact
    public func deleteContact(id: Nat) : async Text {
        // Query Data
        let contactExist : ?Contact = phoneBook.get(id);

        // Switch case to determine if ID exist
        switch (contactExist) {
            // if contact does not exist
            case (null) {
                "Invalid ID, Contact with this ID does not exist"
            };
            // if contact exist
            case (?idExist) {
                ignore phoneBook.remove(id);
                // return 
                return "Contact deleted"
            }
        }
    };

    // function to print contact list
    public query func printContactList() : async [(Nat, Contact)] {
        let contactList: Iter.Iter<(Nat, Contact)> = phoneBook.entries();

        Iter.toArray<(Nat, Contact)>(contactList);
    }


}

