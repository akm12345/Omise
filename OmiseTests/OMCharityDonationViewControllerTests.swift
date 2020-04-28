//
//  OMCharityDonationViewControllerTests.swift
//  OmiseTests
//
//  Created by Amal Mishra on 24/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import XCTest
@testable import Omise

class OMCharityDonationViewControllerTests: XCTestCase {
    
    var donationViewController: OMCharityDonationViewController!
    
    override func setUp() {
        donationViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: OMCharityDonationViewController.self)) as! OMCharityDonationViewController)
        donationViewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        donationViewController = nil
    }
    
    /// Test case view controller outlets
    func testOutletValues(){
        donationViewController.charityName = "Habitat for humanity"
        XCTAssertNotNil(donationViewController.charityName, "Charity name cannot be nil")
        XCTAssertNotNil(donationViewController.donationViewModel, "Donation view model invalid")
        XCTAssertNotNil(donationViewController.publicKey, "Test key cannot be nil")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
