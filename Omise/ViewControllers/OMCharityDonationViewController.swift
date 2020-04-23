//
//  OMCharityDonationViewController.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import UIKit

class OMCharityDonationViewController: OMBaseViewController {
    
    //MARK:- IBoutlets
    @IBOutlet weak var donationAmountTextField: BindingTextField!
    @IBOutlet weak var charityNameLabel: UILabel!
    
    //MARK:- Instance variables
    var charityName: String?
    
    //MARK:- View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- IBAction methods
    @IBAction func donateAmount(_ sender: Any) {
    }

}
