//
//  API.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

/// The class contains the list of all the WebService URLs
class API{
    
    //MARK:- API End points
    static let baseURL = "https://virtserver.swaggerhub.com/chakritw/tamboon-api/1.0.0"
    static let getCharities = API.baseURL + "/charities"
    static let donations = API.baseURL + "/donations"
}
