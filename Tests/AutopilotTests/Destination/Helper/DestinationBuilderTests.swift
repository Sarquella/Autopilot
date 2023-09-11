//
//  DestinationBuilderTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 12/9/23.
//

import XCTest
@testable import Autopilot
import SwiftUI

class DestinationBuilderTests: XCTestCase {
    func build(
        @DestinationBuilder destinations: () -> some Destinable
    ) -> some Destinable {
        destinations()
    }
    
    func test_buildWithSingleDestination_returnsCorrectDestination() {
        typealias D0 = TestDestinable<Int, EmptyView>
        let first: D0 = .init(Int.self)
        
        let result = build {
            first
        }
        
        guard let destination = result as? D0 else {
            return XCTFail("Wrong result type")
        }
        
        XCTAssertEqual(destination, first)
    }
    
    func test_buildWithTwoDestination_returnsDestinationPair() {
        typealias D0 = TestDestinable<Int, EmptyView>
        typealias D1 = TestDestinable<String, EmptyView>
        typealias Pair = DestinationPair<D0, D1>
        let first: D0 = .init(Int.self)
        let second: D1 = .init(String.self)
        
        let result = build {
            first
            second
        }
        
        guard let pair = result as? Pair else {
            return XCTFail("Wrong result type")
        }
        XCTAssertEqual(pair.first, first)
        XCTAssertEqual(pair.second, second)
    }
    
    func test_buildWithMultipleDestination_returnsNestedDestinationPair() {
        typealias D0 = TestDestinable<Int, EmptyView>
        typealias D1 = TestDestinable<String, EmptyView>
        typealias D2 = TestDestinable<Bool, EmptyView>
        typealias InnerPair = DestinationPair<D0, D1>
        typealias OutterPair = DestinationPair<InnerPair, D2>
        let first: D0 = .init(Int.self)
        let second: D1 = .init(String.self)
        let third: D2 = .init(Bool.self)
        
        let result = build {
            first
            second
            third
        }
        
        guard let outterPair = result as? OutterPair else {
            return XCTFail("Wrong result type")
        }
        let innerPair = outterPair.first
        XCTAssertEqual(innerPair.first, first)
        XCTAssertEqual(innerPair.second, second)
        XCTAssertEqual(outterPair.second, third)
    }
}
