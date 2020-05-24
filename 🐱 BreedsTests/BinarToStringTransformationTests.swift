//
//  BinarToStringTransformationTests.swift
//  🐱 BreedsTests
//
//  Created by Oleh Haistruk on 24.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import XCTest
@testable import __Breeds

class BinarToStringTransformationTests: XCTestCase {
    

    func testBinarToStringTransformationFrom0() throws {
        let breedDetailsVC = StringBinar(binarInt: 0).value
        XCTAssertEqual(breedDetailsVC, "No")
    }

    func testBinarToStringTransformationFrom1() throws {
        let breedDetailsVC = StringBinar(binarInt: 1).value
        XCTAssertEqual(breedDetailsVC, "Yes")
    }

    func testBinarToStringTransformationForNotExpectedInt() throws {
        let breedDetailsVC = StringBinar(binarInt: -1).value
        XCTAssertEqual(breedDetailsVC, nil)
    }
}
