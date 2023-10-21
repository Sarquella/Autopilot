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
        @DestinationBuilder destinations: () -> some Destination
    ) -> some Destination {
        destinations()
    }
    
    func test_buildWithSingleDestination_returnsCorrectDestination() {
        typealias D0 = TestDestination<Int>
        let first: D0 = .init(Int.self)
        
        let result = build {
            first
        }
        
        guard let destination = result as? D0 else {
            return XCTFail("Wrong result type")
        }
        
        XCTAssertEqual(destination, first)
    }
    
    func test_buildWithTwoDestinations_returnsDestinationPair() {
        typealias D0 = TestDestination<Int>
        typealias D1 = TestDestination<String>
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
    
    func test_buildWithMultipleDestinations_returnsNestedDestinationPairs() {
        typealias D0 = TestDestination<Int>
        typealias D1 = TestDestination<String>
        typealias D2 = TestDestination<Bool>
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
    
    func test_buildWithSingleModule_returnsCorrectDestination() {
        typealias M0 = TestModule<Int>
        let first: M0 = .init()
        
        let result = build {
            first
        }
        
        XCTAssert(result is M0.Destinations)
    }
    
    func test_buildWithTwoModules_returnsDestinationPair() {
        typealias M0 = TestModule<Int>
        typealias M1 = TestModule<String>
        typealias Pair = DestinationPair<M0.Destinations, M1.Destinations>
        let first: M0 = .init()
        let second: M1 = .init()
        
        let result = build {
            first
            second
        }
        
        XCTAssert(result is Pair)
    }
    
    func test_buildWithMultipleModules_returnsNestedDestinationPairs() {
        typealias M0 = TestModule<Int>
        typealias M1 = TestModule<String>
        typealias M2 = TestModule<Bool>
        typealias InnerPair = DestinationPair<M0.Destinations, M1.Destinations>
        typealias OutterPair = DestinationPair<InnerPair, M2.Destinations>
        let first: M0 = .init()
        let second: M1 = .init()
        let third: M2 = .init()
        
        let result = build {
            first
            second
            third
        }
        
        XCTAssert(result is OutterPair)
    }
    
    func test_buildWithDestinationAndModule_returnsDestinationPair() {
        typealias D0 = TestDestination<Int>
        typealias M0 = TestModule<String>
        typealias Pair = DestinationPair<D0, M0.Destinations>
        let destination: D0 = .init(Int.self)
        let module: M0 = .init()
        
        let result = build {
            destination
            module
        }
        
        XCTAssert(result is Pair)
    }
    
    func test_buildWithMultipleDestinationsAndModules_returnsNestedDestinationPairs() {
        typealias D0 = TestDestination<Int>
        typealias D1 = TestDestination<String>
        typealias M0 = TestModule<Bool>
        typealias M1 = TestModule<Double>
        typealias FirstPair = DestinationPair<D0, M0.Destinations>
        typealias SecondPair = DestinationPair<FirstPair, D1>
        typealias OutterPair = DestinationPair<SecondPair, M1.Destinations>
        let firstDestination: D0 = .init(Int.self)
        let secondDestination: D1 = .init(String.self)
        let firstModule: M0 = .init()
        let secondModule: M1 = .init()
        
        let result = build {
            firstDestination
            firstModule
            secondDestination
            secondModule
        }
        
        XCTAssert(result is OutterPair)
    }
}
