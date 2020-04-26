//
//  DonationViewModel.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

/// This is Viewmodel class for Donation ViewController. It takes al the responsibilties from View controller and it performs all the validations and make donation.
class DonationViewModel{
    
    //MARK:- Instance variables
    var charityName: String?
    var amount: String?
    var token: String?
    
    /// This is repsonsible for calling webservice and getting charities
    var donationManager = OMDataManager()
    
    /// This is used to check if the amount received from Chariry Model is a valid integer or not
    var validAmount: Int?{
        if let amount = amount{
         return Int(amount)
        }
        return nil
    }
    
    //MARK:- Initializer
    init(donationManager: OMDataManager = OMDataManager()) {
        self.donationManager = donationManager
    }
    
    //MARK:- Instance methods
    
    /// This method is used to perform donation
    func donateAmount(completion: @escaping(_ success: Bool?, _ error: String?) -> Void ){
        let params = OMParser.donationParams(donationModel: self)
        donationManager.makeDonation(params: params) { (response, error) in
            if let response = response{
                if response.success{
                    completion(true, nil)
                }else{
                    completion(nil, response.error_message)
                }
            }
        }
    }
    
    /// This method is used to perform validations
    func validateEntries() -> FieldValidationSatus{
        guard charityName != nil else {return FieldValidationSatus.invalid(validationMessage: msgInvalidCharityName)}
        guard let validIntegerAmount = validAmount, validIntegerAmount > 0 else {return FieldValidationSatus.invalid(validationMessage: msgInvalidAmount)}
        guard token != nil else {return FieldValidationSatus.invalid(validationMessage: msgInvalidToken)}
        return FieldValidationSatus.valid
    }
}
