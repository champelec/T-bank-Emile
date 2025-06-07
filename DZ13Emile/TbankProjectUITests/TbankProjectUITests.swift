//
//  TbankProjectUITests.swift
//  TbankProjectUITests
//
//  Created by Эмиль Шамшетдинов on 15.05.2025.
//

import XCTest

final class CoffeeAppUITests: XCTestCase {
    private var testApp: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        testApp = XCUIApplication()
        testApp.launch()
    }
    
    func testAppLaunch() throws {
        XCTAssertTrue(testApp.navigationBars["Coffee Shop"].exists)
    }
    
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
