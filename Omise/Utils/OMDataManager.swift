//
//  OMDataManager.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

class OMDataManager {
    
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
