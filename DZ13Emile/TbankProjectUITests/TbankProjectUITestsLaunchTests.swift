//
//  TbankProjectUITestsLaunchTests.swift
//  TbankProjectUITests
//
//  Created by Эмиль Шамшетдинов on 15.05.2025.
//

import XCTest

final class AppLaunchTests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    func testLaunchScreen() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "App Launch"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
