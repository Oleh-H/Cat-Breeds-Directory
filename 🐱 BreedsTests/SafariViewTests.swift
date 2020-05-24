//
//  SafariViewTests.swift
//  🐱 BreedsTests
//
//  Created by Oleh Haistruk on 24.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import XCTest
import SafariServices
@testable import __Breeds

class SafariViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPreparingSafariViewContrillerFromStringURL() throws {
        let urlString = "https://api.thecatapi.com/v1/breeds"
        let safariView = urlString.urlToSafariViewController()
        XCTAssertNotNil(safariView, "Return SafariViewController instance if URL succesfully initialized from string.")
    }

    func testReturningNilInCaseStringNotContainsURL() {
        let urlString = ""
        let safariView = urlString.urlToSafariViewController()
        XCTAssertNil(safariView, "Return nil in case URL can't be succesfully initialized from string.")
    }


}
