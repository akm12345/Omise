//
//  OmErrorsTests.swift
//  OmiseTests
//
//  Created by Amal Mishra on 29/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import XCTest
@testable import Omise

class OmErrorsTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

     /// This test case checks if all the Omise Errors enums are showing correct error description
    func testOmiseErrorsDescription(){
        XCTAssertEqual(OMErrors.httpErrorResponseWithInvalidData.errorDescription, "Http response with invalid data", "Invalid error description")
        XCTAssertEqual(OMErrors.httpErrorWithNoData.errorDescription, "Http error with wo data", "Invalid error description")
        XCTAssertEqual(OMErrors.httpSucceessWithNoData.errorDescription, "Http request succeess with no sata", "Invalid error description")
        XCTAssertEqual(OMErrors.httpErrorResponseWithInvalidData.errorDescription, "Http response with invalid data", "Invalid error description")
        XCTAssertEqual(OMErrors.unrecognizedHTTPStatusCode.errorDescription, "Unrecognized HTTP status Code", "Invalid error description")
        XCTAssertEqual(OMErrors.unexpected.errorDescription, "Unexpected error", "Invalid error description")
        XCTAssertEqual(OMErrors.parsingError.errorDescription, "Invalid data", "Invalid error description")
    }
}
