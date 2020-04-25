//
//  CharityListViewModelTests.swift
//  OmiseTests
//
//  Created by Amal Mishra on 24/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import XCTest
@testable import Omise

class CharityListViewModelTests: XCTestCase {
    
    var chartyListViewModel: CharityListViewModel!

    override func setUp() {
        chartyListViewModel = CharityListViewModel(imageUrl: "http://www.adamandlianne.com/uploads/2/2/1/6/2216267/3231127.gif", charityName: "Habitat for Humanity")
    }

    override func tearDown() {
       chartyListViewModel = nil
    }
    
    func testCharityModelForCorrectValues(){
        XCTAssertNotNil(chartyListViewModel.imageUrl)
        XCTAssertNotNil(chartyListViewModel.charityName)
        
        XCTAssertEqual(chartyListViewModel.charityName, "Habitat for Humanity")
        XCTAssertEqual(chartyListViewModel.imageUrl, "http://www.adamandlianne.com/uploads/2/2/1/6/2216267/3231127.gif")
    }
    
    func testCharityModelForInCorrectValues(){
        XCTAssertNotEqual(chartyListViewModel.charityName, "")
        XCTAssertNotEqual(chartyListViewModel.charityName, "Habitat")
        XCTAssertNotEqual(chartyListViewModel.imageUrl, "")
        XCTAssertNotEqual(chartyListViewModel.imageUrl, "http://www.adamandlianne.com")
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
