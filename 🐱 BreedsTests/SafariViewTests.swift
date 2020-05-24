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

    func testPreparingSafariViewContrillerFromStringURL() {
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
