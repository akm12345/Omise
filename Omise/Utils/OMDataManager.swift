//
//  OMDataManager.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

///This class takes the responsibility od calling the WebService and returns the formatted models using OMParser
class OMDataManager {
    
    //// This method is used to perform a webService request to get the list of available charities
    /// - Parameter completion: completion handler containing charities  and  error. It returns either a list of charitis after parsing the data or string description of error in case the request is not sucessful.
    func getCharitiesList(completion: @escaping(_ charities: [Charity]? , _ error: String?)  -> Void){
        Webservice.GETrequest(with: API.getCharities) { (data, error) in
            if let error = error{
                completion(nil, error)
            }
            if let data = data, let charities = OMParser.parseCharities(data: data){
                completion(charities, nil)
            }
        }
    }
    
    //// This method is used to perform a webService request to donate an amount to the charity
    /// - Parameter params: donation parameters required for POST end point API request
    /// - Parameter completion: completion handler containing response model  and  error. It returns either a a valid Omise Response Model after parsing the data or string description of error in case the request is not sucessful.
    func makeDonation(params: JSONdictionary, completion: @escaping(_ result: OmResponseModel? , _ error: String?)  -> Void){
        Webservice.POSTrequest(with: API.donations, bodyType: .formData, body: params) { (data, error) in
            if let error = error{
                completion(nil, error)
            }
            if let data = data, let response = try? JSONDecoder().decode(OmResponseModel.self, from: data){
                completion(response, nil)
            }
        }
    }
}
