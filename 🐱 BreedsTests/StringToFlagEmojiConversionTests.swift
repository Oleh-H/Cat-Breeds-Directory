//
//  StringToFlagEmojiConversionTests.swift
//  🐱 BreedsTests
//
//  Created by Oleh Haistruk on 24.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import XCTest
@testable import __Breeds

class StringToFlagEmojiConversionTests: XCTestCase {

    let emojiManager = EmojiManager()

    func testCorrectStringConversion() {
        let correctUSLocationName = "us"
        let emoji = "🇺🇸"
        let usFlagEmoji = emojiManager.emojiFlag(regionCode: correctUSLocationName)
        XCTAssertEqual(usFlagEmoji, emoji, "Expects to be equal")
    }
    
    func testNotCorrectStringConversion() {
        let notCorrectUSLocationName = "usa"
        let emptyString = ""
        let usFlagEmoji = emojiManager.emojiFlag(regionCode: notCorrectUSLocationName)
        XCTAssertEqual(usFlagEmoji, emptyString, "In case of wrong string passed to the function should return empty string.")
    }

    func testNilStringConversion() {
        let nilString: String? = nil
        let emptyString = ""
        let flagEmoji = emojiManager.emojiFlag(regionCode: nilString)
        XCTAssertEqual(flagEmoji, emptyString, "In case string contains nil function returns empty string.")
    }

}
