//
//  PresentationPairTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 1/10/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
@testable import ViewInspector

class PresentationPairTests: XCTestCase {
    func test_initWithPresentations_returnsCorrectPresentations() {
        typealias Destination = TestDestination<Int>
        typealias P0 = FirstPresentation<Destination>
        typealias P1 = SecondPresentation<Destination>
        typealias Pair = PresentationPair<Destination, P0, P1>

        let first: P0 = .init()
        let second: P1 = .init()
        let pair = Pair(first: first, second: second)
        
        XCTAssertEqual(pair.first, first)
        XCTAssertEqual(pair.second, second)
    }
    
    func test_registerPairPresentation_registersChildPresentations() throws {
        typealias Destination = TestDestination<Int>
        typealias P0 = FirstPresentation<Destination>
        typealias P1 = SecondPresentation<Destination>
        typealias Pair = PresentationPair<Destination, P0, P1>
        
        let destination = Destination(Int.self)
        let first: P0 = .init()
        let second: P1 = .init()
        let pair = Pair(first: first, second: second)
        
        let body = EmptyView()
            .environmentObject(Router())
            .presentations(for: destination) {
                pair
            }
        
        let modifiedBody = try body
            .inspect()
            .modifier(_PresentationModifier<Pair>.self)
            .actualView()
            .body(content: .init())
        
        let firstModifier = try modifiedBody
            .inspect()
            .modifier(_PresentationModifier<P0>.self)
            .actualView()
        XCTAssertEqual(firstModifier.presentation, first)
        XCTAssertEqual(firstModifier.destination, destination)
        
        let secondModifier = try modifiedBody
            .inspect()
            .modifier(_PresentationModifier<P1>.self)
            .actualView()
        XCTAssertEqual(secondModifier.presentation, second)
        XCTAssertEqual(secondModifier.destination, destination)
    }
}
