//
//  DictionaryStreamTests.swift
//  Stream
//
//  Created by Bernardo Breder on 27/01/17.
//
//

import XCTest
@testable import Stream

class DictionaryStreamTests: XCTestCase {
    
    func test() {
        XCTAssertEqual(["id": 2], ["id": 1].stream.mapValues({(k,v) in v+1}).consume())
        XCTAssertEqual(["idd": 1], ["id": 1].stream.mapKeys({(k,v) in k + "d"}).consume())
        XCTAssertEqual(["idd": 2], ["id": 1, "idd": 2].stream.filter({(k,v) in v > 1}).consume())
        XCTAssertEqual(["id"], ["id": 1].stream.keys().consume())
        XCTAssertEqual(["idd"], ["id": 1].stream.keys({(k,v) in k + "d"}).consume())
        XCTAssertEqual([2], ["id": 1].stream.values({(k,v) in v + 1}).consume())
        XCTAssertEqual(["id": 1], ["id": 1].stream.filter { k, v in v == 1 }.consume())
        XCTAssertEqual([:], ["id": 1].stream.filter { k, v in v == 2 }.consume())
        XCTAssertEqual(1, ["id": 1].stream.filter { k, v in v == 1 }.first?.value)
    }
    
}

