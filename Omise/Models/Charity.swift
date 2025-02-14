//
//  Charity.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

///Charity List  model, as per the charities API response format
struct CharityListModel: Codable{
    var data : [Charity]
}

struct Charity: Codable{
    var id: Int
    var name: String
    var logo_url: String
}
