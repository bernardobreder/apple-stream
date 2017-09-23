//
//  StreamTests.swift
//  Stream
//
//  Created by Bernardo Breder.
//
//

import XCTest
@testable import StreamTests

extension DictionaryStreamTests {

	static var allTests : [(String, (DictionaryStreamTests) -> () throws -> Void)] {
		return [
			("test", test),
		]
	}

}

extension StreamTests {

	static var allTests : [(String, (StreamTests) -> () throws -> Void)] {
		return [
			("test", test),
			("testConcat", testConcat),
			("testPerformanceExample", testPerformanceExample),
			("testPerformanceNative", testPerformanceNative),
			("testSet", testSet),
		]
	}

}

XCTMain([
	testCase(DictionaryStreamTests.allTests),
	testCase(StreamTests.allTests),
])

