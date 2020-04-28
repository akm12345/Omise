//
//  DonationViewModelTests.swift
//  OmiseTests
//
//  Created by Amal Mishra on 24/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import XCTest
@testable import Omise

class DonationViewModelTests: XCTestCase {
    
    var donationViewModel : DonationViewModel!
    
    override func setUp() {
        let donationManager = OMDataManager()
        donationViewModel = DonationViewModel(donationManager: donationManager)
        donationViewModel.amount = "200"
        donationViewModel.charityName = "Habitat for Humanity"
        donationViewModel.token = "pkey_test_5ivhwgv1rrj1la797si"
    }
    
    override func tearDown() {
        donationViewModel = nil
    }
    
    func testDonationModelForCorrectValues(){
        XCTAssertNotNil(donationViewModel.amount, "Amount cannnot be nil")
        XCTAssertNotNil(donationViewModel.charityName, "Charity name cannot be nil")
        XCTAssertNotNil(donationViewModel.token, "Token cannot be nil")
        
        XCTAssertEqual(donationViewModel.amount, "200", "Incorrect amount value")
        XCTAssertEqual(donationViewModel.charityName, "Habitat for Humanity", "Charity Name is not correct")
        XCTAssertEqual(donationViewModel.token, "pkey_test_5ivhwgv1rrj1la797si", "Wrong token")
    }
    
    func testDonationModelForInCorrectValues(){
        XCTAssertNotEqual(donationViewModel.amount, "", "Invalid amount")
        XCTAssertNotEqual(donationViewModel.charityName, "Charity name cannot be empty")
        XCTAssertNotEqual(donationViewModel.token, "Token cannot be empyty")
        
        XCTAssertNotEqual(donationViewModel.amount, "54", "Incorrect amount")
        XCTAssertNotEqual(donationViewModel.charityName, "gklklg", "Wrong charity name")
        XCTAssertNotEqual(donationViewModel.token, "dgklgkl", "Incorrect token")
    }
    
    func testDonationAmountIsValid(){
        XCTAssertNotNil(donationViewModel.validAmount)
        XCTAssertEqual(donationViewModel.validAmount, 200, "Computed amount value is incorrect")
        donationViewModel.amount = "200.45"
        XCTAssertNil(donationViewModel.validAmount, "Computed amount is not a valid integer")
        donationViewModel.amount = ""
        XCTAssertNil(donationViewModel.validAmount, "Computed amount is not a valid integer")
        donationViewModel.amount = "dshj"
        XCTAssertNil(donationViewModel.validAmount, "Computed amount is not a valid integer")
    }
    
    func testdonationViewModelValidations(){
        XCTAssertEqual(donationViewModel.validateEntries(), FieldValidationSatus.valid, "View Model validations failed")
        donationViewModel.amount = "NA"
        XCTAssertEqual(donationViewModel.validateEntries(), FieldValidationSatus.invalid(validationMessage: msgInvalidAmount), "View Model validations failed")
    }
    
    func testValidationMessageForIncorrectCharityName(){
        donationViewModel.charityName = nil
        let validationStatus = donationViewModel.validateEntries()
        switch validationStatus {
        case .invalid(let msg):
            XCTAssertEqual(msg, msgInvalidCharityName, "Incorrect validation message for Charity name")
        default: break
        }
    }
    
    func testValidationMessageForIncorrectToken(){
        donationViewModel.token = nil
        let tokenValidationStatus = donationViewModel.validateEntries()
        switch tokenValidationStatus {
        case .invalid(let msg):
            XCTAssertEqual(msg, msgInvalidToken, "Incorrect validation message for token")
        default: break
        }
    }
    
    func testValidationMessageForIncorrectAmount(){
        donationViewModel.amount = nil
        let amountValidationStatus = donationViewModel.validateEntries()
        switch amountValidationStatus {
        case .invalid(let msg):
            XCTAssertEqual(msg, msgInvalidAmount, "Invalid validation message for amount")
        default: break
        }
    }
    
    func testDonationWithExpectation(){
        let expect = expectation(description: "Donation should succeed")
        donationViewModel.donateAmount { (success, error) in
            XCTAssertNil(error, "Donation failed with error:- \(error!)")
            XCTAssertNotNil(success, "Failed to donate amount")
            XCTAssertEqual(success, true, "Failed to donate amount")
            expect.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Test timed Out")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
