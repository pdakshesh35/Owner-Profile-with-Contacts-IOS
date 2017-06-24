//
//  ViewController.swift
//  OwnerProfile_Contacts
//
//  Created by Dakshesh patel on 6/24/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit
import Contacts
import AddressBook

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameFull: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNo: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func getContact(_ sender: AnyObject) {
        
        let profile = DeviceProfile()
        profile.initialization()
        
        
        nameFull.text = profile.getName()
        email.text = profile.getEmail()
        phoneNo.text = profile.getPhoneNumber()
        address.text = profile.getAddress()
        
        
        
    }
    
}

