//
//  OmiseUITests.swift
//  OmiseUITests
//
//  Created by Amal Mishra on 22/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import XCTest

class OmiseUITests: XCTestCase {
    
    //MARK:- Instance variables
    var app: XCUIApplication!
    
    //MARK:- Test lifecycle methods
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK:- Test methods
    
    /// This test is used to check wether the first screen displayed is charity list screen or not
    func testNavigationBarOfFirstScreenDisplays(){
        XCTAssertTrue(app.navigationBars["Charites"].exists)
    }
    
    /// This test is used to check wether the charity list retrieved from API is correctly displayed on donation screen
    func testCorrectCharityNameDisplayedOnDonationScreen(){
        let charityTableViewCell = app.tables.cells["CharityTableCell"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: charityTableViewCell, handler: nil)
        waitForExpectations(timeout: 20, handler: nil)
        XCTAssertTrue(charityTableViewCell.exists)
        
        let charityNameElementOnCharityListScreen = app.tables.staticTexts["CharityTableCellLabel"]
        let labelExists = NSPredicate(format: "exists == 1")
        expectation(for: labelExists, evaluatedWith: charityNameElementOnCharityListScreen, handler: nil)
        waitForExpectations(timeout: 20, handler: nil)
        
        XCTAssertTrue(charityNameElementOnCharityListScreen.exists)
        
        charityTableViewCell.tap()
        
        let charityNameElementOnDonationScreen = app.staticTexts["CharityNameLabel"]
        XCTAssertTrue(charityNameElementOnDonationScreen.exists)
        
        XCTAssertEqual(charityNameElementOnDonationScreen.label, charityNameElementOnCharityListScreen.label, "Charity name does not match")
    }
    
    /// This test checks if all the UI elements are displayed correctly on charity lisct screen or not
    func testCharityListTableViewDisplays(){
        let charityTableViewCell = app.tables.cells["CharityTableCell"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: charityTableViewCell, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(charityTableViewCell.exists)
        
        let labelElement = app.staticTexts.element(matching: .any, identifier: "CharityTableCellLabel")
        XCTAssertTrue(labelElement.exists)
    }
    
    ///This test case runs complete cycle of app for a successful donation. It simulates the overall process which includes displaying of  charities, adding a particular donation amount, adding dummy credit card details, making donatiion, displaying donation successful screen and then finally navigating back to charity list screen after tapping dismss.
    func testCompleteDonationProcess() {
        
        let charityTableViewCell = app.tables.cells["CharityTableCell"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: charityTableViewCell, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(charityTableViewCell.exists)
        charityTableViewCell.tap()
        
        let amountTextField = app.textFields["DonationTextField"]
        amountTextField.tap()
        amountTextField.typeText("100")
        
        let donationButton = app.buttons["DonateButton"]
        XCTAssert(donationButton.exists)
        donationButton.tap()
        
        let cardNoTextFieldTextField = app.scrollViews.containing(.staticText, identifier:"Card number").children(matching: .textField).element(boundBy: 0)
        cardNoTextFieldTextField.tap()
        XCTAssert(cardNoTextFieldTextField.exists)
        cardNoTextFieldTextField.typeText("4242424242424242")
        
        let nameTextField = app.scrollViews.children(matching: .textField).element(boundBy: 1)
        XCTAssert(nameTextField.exists)
        nameTextField.tap()
        nameTextField.typeText("Jack J")
        
        let expiryDateTextField = app.scrollViews.children(matching: .textField).element(boundBy: 2)
        XCTAssert(expiryDateTextField.exists)
        expiryDateTextField.tap()
        expiryDateTextField.typeText("0324")
        
        let cvvTextField = app.scrollViews.children(matching: .textField).element(boundBy: 3)
        XCTAssert(cvvTextField.exists)
        cvvTextField.tap()
        cvvTextField.typeText("4444")
        
        XCTAssert(app.buttons["Pay"].exists)
        app.buttons["Pay"].tap()
        
        let dismissButton = app.buttons["DismissButton"]
        let dismissButtonExists = NSPredicate(format: "exists == 1")
        expectation(for: dismissButtonExists, evaluatedWith: dismissButton, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssert(dismissButton.exists)
        dismissButton.tap()
        
    }
    
    /// This test case is used to check if the correct alert message is shown when invalid donation amount is entered
    func testInvalidDonationAmountAlert(){
        let charityTableViewCell = app.tables.cells["CharityTableCell"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: charityTableViewCell, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(charityTableViewCell.exists)
        charityTableViewCell.tap()
        
        let amountTextField = app.textFields["DonationTextField"]
        //amountTextField.tap()
        
        let donationButton = app.buttons["DonateButton"]
        XCTAssert(donationButton.exists)
        donationButton.tap()
        
        let elementsQuery = app.alerts["Omise"].scrollViews.otherElements
        XCTAssertTrue(elementsQuery.staticTexts["Omise"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Invalid Amount. \n Donation amount must be greater than 0"].exists)
        
        amountTextField.tap()
        amountTextField.typeText("dskj")
        donationButton.tap()
        XCTAssertTrue(elementsQuery.staticTexts["Omise"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Invalid Amount. \n Donation amount must be greater than 0"].exists)
        
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
