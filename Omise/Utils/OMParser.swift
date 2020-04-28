//
//  OMParser.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

///Generic Omise  API Response Model
struct OmResponseModel: Codable{
    let success: Bool
    let error_code: String
    let error_message: String
}

/// This class will be responsible for all the parsing
class OMParser{
    
    /// This method is used to parse all the API responses and returns an error message in case the request is not a success
    /// - Parameter data: Data
    /// - Returns: an error message if there is one, else returns nil
    static func errorInResponse(data: Data) -> String? {
        do{
            let response = try JSONDecoder().decode(OmResponseModel.self, from: data)
            return response.success ? nil : response.error_message
        }catch{
            return nil
        }
    }
    
    /// This method is used to parse the data and return a list available charities
    /// - Parameter data: Data
    /// - Returns: an array of charities
    static func parseCharities(data: Data) -> [Charity]?{
        do{
            let charitiesModel = try JSONDecoder().decode(CharityListModel.self, from: data)
            return charitiesModel.data
        }catch{
            return nil
        }
    }
    
    //// This method is used to form params for a donation API
    /// - Parameter donationModel: donation model containing related info
    /// - Returns: a JSON formatted dictionary with key value pairs
    static func donationParams(donationModel: DonationViewModel) -> JSONdictionary{
        return ["charityName" : donationModel.charityName,
                "amount": donationModel.amount,
                "token": donationModel.token]
    }
}

