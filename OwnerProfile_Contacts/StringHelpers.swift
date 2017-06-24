//
//  StringHelpers.swift
//  OwnerProfile_Contacts
//
//  Created by Dakshesh patel on 6/24/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import Foundation

extension String {
    
    /// Trim a string
    var trimmedString: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
}
