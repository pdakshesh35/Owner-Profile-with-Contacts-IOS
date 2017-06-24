//
//  DeviceProfile.swift
//  Prefill
//
//  Created by Dakshesh patel on 6/24/17.
//  Copyright © 2017 Dashbox. All rights reserved.
//

import Foundation
import UIKit
import Contacts

class DeviceProfile {
    var nameFirst : String = ""
    var nameLast : String = ""
    var email : String = ""
    var phonNo : String = ""
    var address : String = ""
    
    
    func initialization() {
        if(AccessProfile()) {
            //variables have been already initialized
        } else {
            //cant access to the contacts
            print("false, access not granted")
        }
    }
    
    func getName() -> String {
        return nameFirst + " " + nameLast
    }
    
    func getPhoneNumber() -> String {
        return self.phonNo
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getAddress() -> String {
        return self.address
    }
    fileprivate func AccessProfile() -> Bool{
        let ownerName = getOwnerName()
        let store = CNContactStore()
        
        do {
            // Ask permission from the addressbook and search for the user using the owners name
            let contacts = try store.unifiedContacts(matching: CNContact.predicateForContacts(matchingName: ownerName), keysToFetch:[CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactPostalAddressesKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor])
            
            
            //assuming contain at least one contact
            if let contact = contacts.first {
                // Checking if phone number is available for the given contact.
                if (contact.isKeyAvailable(CNContactPhoneNumbersKey)) {
                    // Populate the fields
                    populateUsingContact(contact)
                } else {
                    //Refetch the keys
                    let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactPostalAddressesKey, CNContactEmailAddressesKey]
                    let refetchedContact = try store.unifiedContact(withIdentifier: contact.identifier, keysToFetch: keysToFetch as [CNKeyDescriptor])
                    
                    // Populate the fields
                    populateUsingContact(refetchedContact)
                }
            }
            return true
            
        } catch let e as NSError {
            
            //access not granted
            print(e.localizedDescription)
            return false
        }
        
    }
    
    /**
     Get the device owners name
     
     - returns: The owners name
     */
    fileprivate func getOwnerName() -> String {
        // Get the device owners name
        var ownerName = UIDevice.current.name.trimmedString.replacingOccurrences(of: "'", with: "")
        // Get the model of the device
        let model = UIDevice.current.model
        
        // Remove the device name from the owners name
        if let t = ownerName.range(of: "s \(model)") {
            ownerName = ownerName.substring(to: t.lowerBound)
        }
        
        return ownerName.trimmedString
    }
    
    /**
     Populate the fields using a contact
     
     - parameter contact: The contact to use
     */
    fileprivate func populateUsingContact(_ contact: CNContact) {
        // Set the name fields
        self.nameFirst = contact.givenName
        self.nameLast = contact.familyName
        
        // Check if there is an address available, it might be empty
        if contact.isKeyAvailable(CNContactPostalAddressesKey) {
            if let
                addrv = contact.postalAddresses.first,
                let addr = addrv.value as? CNPostalAddress, addrv.value is CNPostalAddress
            {
                let address = "\(addr.street)\n\(addr.postalCode) \(addr.city)\n\(addr.country)"
                self.address = address
            }
        }
        
        // Check if there is a phonenumber available, it might be empty
        if contact.isKeyAvailable(CNContactPhoneNumbersKey) {
            if let
                phonenumberValue = contact.phoneNumbers.first,
                let pn = phonenumberValue.value as? CNPhoneNumber, phonenumberValue.value is CNPhoneNumber
            {
                self.phonNo = pn.stringValue
                
                
            }
        }
        
        if contact.isKeyAvailable(CNContactEmailAddressesKey) {
            if let emailValue = contact.emailAddresses.first?.value as? String {
                self.email = emailValue
            }
        }
    }
    
}
