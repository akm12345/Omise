//
//  WebServiceConstants.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

/// The class represents all the constants related to WebService
class WebServiceConstants{
    //MARK:- Request types
    static let GET = "GET"
    static let POST = "POST"
    static let PUT = "PUT"
    static let PATCH = "PATCH"
    static let DELETE = "DELETE"
    
    //MARK:- Symbols
    static let SLASH = "/"
    static let NEWLINE = "\n"
    static let COLON = ":"
    
    //MARK:- Locale
    static let EN = "en"
    
    //MARK:- Headers List
    static let SERVER_HEADER_KEYS_AUTHORIZATION = "Authorization"
    static let SERVER_HEADER_KEYS_ACCEPT = "Accept"
    
    //MARK:- Server Constants
    static let DEFAULT_ACCEPT_HEADER = "application/json"
    static let DEFAULT_CONTENT_TYPE = "application/json; charset=UTF-8"
    
    enum WEBSERVICE_RESPONSE_CONSTANTS: Int {
        case OK = 200
        case CREATED = 201
        case ACCEPTED = 202
        case NO_CONTENT = 204
        case PARTIAL_CONTENT = 206
        case BAD_REQUEST = 400
        case UNAUTHORIZED = 401
        case FORBIDDEN = 403
        case NOT_FOUND = 404
        case REQUEST_TIMED_OUT = 408
        case CONFLICT = 409
        case UNKNOWN_ERROR = 99999
    }
}
