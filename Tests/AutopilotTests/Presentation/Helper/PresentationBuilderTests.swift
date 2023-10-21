//
//  PresentationBuilderTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 1/10/23.
//

import XCTest
@testable import Autopilot
import SwiftUI

class PresentationBuilderTests: XCTestCase {
    func build(
        @PresentationBuilder presentations: () -> some Presentation
    ) -> some Presentation {
        presentations()
    }
    
    func test_buildWithSinglePresentation_returnsCorrectPresentation() {
        typealias P0 = FirstPresentation<TestDestination<Int>>
        let first: P0 = .init()
        
        let result = build {
            first
        }
        
        guard let presentation = result as? P0 else {
            return XCTFail("Wrong result type")
        }
        
        XCTAssertEqual(presentation, first)
    }
    
    func test_buildWithTwoPresentations_returnsPresentationPair() {
        typealias Destination = TestDestination<Int>
        typealias P0 = FirstPresentation<Destination>
        typealias P1 = SecondPresentation<Destination>
        typealias Pair = PresentationPair<Destination, P0, P1>
        let first: P0 = .init()
        let second: P1 = .init()
        
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
    
    func test_buildWithMultiplePresentations_returnsNestedPresentationsPairs() {
        typealias Destination = TestDestination<Int>
        typealias P0 = FirstPresentation<Destination>
        typealias P1 = SecondPresentation<Destination>
        typealias P2 = ThirdPresentation<Destination>
        typealias InnerPair = PresentationPair<Destination, P0, P1>
        typealias OutterPair = PresentationPair<Destination, InnerPair, P2>
        let first: P0 = .init()
        let second: P1 = .init()
        let third: P2 = .init()
        
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
