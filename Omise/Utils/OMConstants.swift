//
//  OMConstants.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

//MARK:- Global Constants to be used throughout the app
let kDefaultTimeOutInterval = 60
let kAllowedCharacterSetForDonationAnount = "0123456789."

enum AuthHeaders : String {
    case Content_Type = "Content-Type"
}

enum FieldValidationSatus : Equatable{
    case valid
    case invalid(validationMessage: String)
}

let ktestPublicKey = "pkey_test_5ivhwgv1rrj1la797si"
