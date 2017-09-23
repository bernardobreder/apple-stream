//
//  Stream.swift
//  Stream
//
//  Created by Bernardo Breder on 20/01/17.
//
//

import XCTest
@testable import Stream

class StreamTests: XCTestCase {
    
    func testConcat() {
        XCTAssertEqual([1, 2], [1].stream.concat([2].stream).consume())
        XCTAssertEqual([1, 2, 3], [1].stream.concat([2].stream).concat([3].stream).consume())
    }
    
    func testSet() {
//        XCTAssertEqual([1, 2, 3], [1, 2, 3].stream.set().consume().sorted())
        XCTAssertEqual([1, 2], [1, 2, 2].stream.set().consume().sorted())
        XCTAssertEqual([1], [1, 1, 1].stream.set().consume().sorted())
        XCTAssertEqual([1, 2], [2, 1, 1].stream.set().consume().sorted())
        XCTAssertEqual([1, 2], [1, 2, 1].stream.set().consume().sorted())
    }

	func test() {
        XCTAssertEqual(21, [1].stream
            .map{(i: Int) in i+1}.filter{(i: Int) in i>0}.filter{(i: Int) in i>0}.map{(i: Int) in i+1}
            .map{(i: Int) in i+1}.filter{(i: Int) in i>0}.filter{(i: Int) in i>0}.map{(i: Int) in i+1}
            .map{(i: Int) in i+1}.filter{(i: Int) in i>0}.filter{(i: Int) in i>0}.map{(i: Int) in i+1}
            .map{(i: Int) in i+1}.filter{(i: Int) in i>0}.filter{(i: Int) in i>0}.map{(i: Int) in i+1}
            .map{(i: Int) in i+1}.filter{(i: Int) in i>0}.filter{(i: Int) in i>0}.map{(i: Int) in i+1}
            .map{(i: Int) in i+1}.filter{(i: Int) in i>0}.filter{(i: Int) in i>0}.map{(i: Int) in i+1}
            .map{(i: Int) in i+1}.filter{(i: Int) in i>0}.filter{(i: Int) in i>0}.map{(i: Int) in i+1}
            .map{(i: Int) in i+1}.filter{(i: Int) in i>0}.filter{(i: Int) in i>0}.map{(i: Int) in i+1}
            .map{(i: Int) in i+1}.filter{(i: Int) in i>0}.filter{(i: Int) in i>0}.map{(i: Int) in i+1}
            .map{(i: Int) in i+1}.filter{(i: Int) in i>0}.filter{(i: Int) in i>0}.map{(i: Int) in i+1}
            .reduce(0, {(a: Int, b: Int) in a + b}).consume())
	}
    
    func testPerformanceExample() {
        var array: [Int] = []
        for i in 1 ... 128 * 1024 { array.append(i) }
        let stream = array.stream
        self.measure {
            _ = stream.map({$0+1}).consume()
        }
    }
    
    func testPerformanceNative() {
        var array: [Int] = []
        for i in 1 ... 128 * 1024 { array.append(i) }
        self.measure {
            _ = array.map({$0+1})
        }
    }

}

