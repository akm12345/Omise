//
//  OMErrors.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

///This enum is to represent various errors
enum OMErrors: String{
    case httpErrorWithNoData
    case httpErrorResponseWithInvalidData
    case httpSucceessWithNoData
    case httpSucceessWithInvalidData
    case unrecognizedHTTPStatusCode
    case unexpected
    case parsingError
    
    /// String description of respective errors
    public var errorDescription : String{
        switch self {
        case .httpErrorWithNoData:
            return "Http error with wo data"
        case .httpErrorResponseWithInvalidData:
            return "Http response with invalid data"
        case .httpSucceessWithNoData:
            return "Http request succeess with no sata"
        case .httpSucceessWithInvalidData:
            return "Http request succeess with invalid sata"
        case .unrecognizedHTTPStatusCode:
            return "Unrecognized HTTP status Code"
        case .unexpected:
            return "Unexpected error"
        case .parsingError:
            return "Invalid data"
        }
    }
}
