//
//  LocallizedStringTypeTests.swift
//  TechTestTests
//
//  Created by wyn on 2023/1/16.
//

import XCTest
@testable import TechTest

final class LocallizedStringTypeTests: XCTestCase {
    enum MockString: LocallizedStringType {
        case contentA
        case contentB
    }
    func testLocallizedString_defineKey_PrefixAndText() {
        let prefixA = MockString.contentA.prefix
        let prefixB = MockString.contentB.prefix
        XCTAssertEqual(prefixA, "MockString")
        XCTAssertEqual(prefixB, "MockString")
        let textA = MockString.contentA.text
        let textB = MockString.contentB.text
        XCTAssertEqual(textA, "MockString.contentA")
        XCTAssertEqual(textB, "MockString.contentB")
    }
}
