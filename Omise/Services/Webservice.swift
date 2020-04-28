//
//  Webservice.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

typealias JSONArray = [Any?]
typealias Parameters = [String: String]
typealias JSONdictionary = [String: Any?]
typealias networkResponse = (_ data: Data?, _ error: String?) -> Void

/// Valid Post request types
enum PostBodyType {
    case none
    case formData
    case urlEncoded
    case raw
}

/// Web service class to perform all the API requests
class Webservice{
    
    typealias serviceConstants = WebServiceConstants
    
    //MARK:- Methods
    /// Webservice method to perform a GET request
    /// - Parameter urlString: API end point
    /// - Parameter completion: valid network response containing data/error message
    static func GETrequest(with urlString: String, completion: @escaping networkResponse ) {
        
        guard let url = URL(string: urlString) else {
            completion(nil, msgInvalidURL)
            return
        }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: TimeInterval(kDefaultTimeOutInterval))
        
        request.allHTTPHeaderFields = headers(requestType: serviceConstants.GET)
        
        request.httpMethod = serviceConstants.GET
        
        performRequest(request: request) { (data, error) in
            completion(data, error)
        }
    }
    
    /// Webservice method to perform a POST request
    /// - Parameter urlString: API end point
    /// - Parameter bodyType: PostBodyType
    /// - Parameter body: Dictionary containg post body data
    /// - Parameter completion: valid network response containing data/error message
    static func POSTrequest(with urlString: String, bodyType: PostBodyType, body: JSONdictionary, completion: @escaping networkResponse) {
        
        guard let url = URL(string: urlString) else {
            completion(nil, msgInvalidURL)
            return
        }
        
        guard let bodyData = data(for: bodyType, body: body) else {
            completion(nil, msgInvalidParameter)
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: TimeInterval(kDefaultTimeOutInterval))
        
        request.allHTTPHeaderFields = headers(requestType: serviceConstants.POST)
        request.httpMethod = serviceConstants.POST
        
        request.httpBody = bodyData
        
        performRequest(request: request) { (data, error) in
            completion(data, error)
        }
    }
    
    /// This encodes the given body and returns a valid data
    /// - Parameter bodyType: PostBodyType
    /// - Parameter body: JSONdictionary containing the body of POST request
    /// - Returns: valid encoded data
    private static func data(for bodyType: PostBodyType, body: JSONdictionary) -> Data? {
        switch bodyType {
        case .none:
            //TODO:- Not required
            return nil
        case .formData:
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                return jsonData
            }
            catch{
                return nil
            }
        case .urlEncoded:
            //TODO:- Not required
            return nil
        case .raw:
            //TODO:- Not required
            return nil
        }
    }
    
    ///Headers, needed to be included in all api requests
    /// - Parameter request: API  request type
    /// - Returns: Dictionary containing valid headers
    private static func headers(requestType: String) -> [String: String] {
        
        let authheader = [
            AuthHeaders.Content_Type.rawValue : serviceConstants.DEFAULT_ACCEPT_HEADER,
        ]
        return authheader
    }
    
    /// This performs a URLRequest with default session configuration
    /// - Parameter request: URLRequest
    /// - Parameter completion: Completion handler that returns either a valid data or an error message
    private static func performRequest(request: URLRequest, completion : @escaping  networkResponse ){
        
        let defaultSession = URLSession(configuration: .default)
        
        let dataTask = defaultSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error.localizedDescription)
                }
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 400..<600:
                        guard let data = data else{
                            completion(nil, OMErrors.httpErrorWithNoData.errorDescription)
                            return
                        }
                        if let errorDescription = OMParser.errorInResponse(data: data){
                            completion(nil, errorDescription)
                        }
                    case 200..<300:
                        guard let data = data else{
                            completion(nil, OMErrors.httpSucceessWithNoData.errorDescription)
                            return
                        }
                        if let errorDescription = OMParser.errorInResponse(data: data){
                            completion(nil, errorDescription)
                        }else{
                            completion(data, nil)
                        }
                    default:
                        completion(nil, OMErrors.unexpected.errorDescription)
                    }
                }
                else {
                    completion(nil, msgDefaultError)
                }
            }
        }
        dataTask.resume()
    }
}
