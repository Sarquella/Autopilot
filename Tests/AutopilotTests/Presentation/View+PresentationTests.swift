//
//  View+PresentationTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 1/10/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
import ViewInspector

class ViewPresentationTests: XCTestCase {
    var root: some View {
        EmptyView()
            .environmentObject(Router())
    }
    
    func test_registerSinglePresentation_addCorrectModifier() throws {
        typealias Destination = TestDestination<Int>
        typealias Presentation = FirstPresentation<Destination>
        
        let destination = Destination(Int.self)
        let presentation = Presentation()
        
        let body = root.presentations(for: destination) {
            presentation
        }
        
        let modifier = try body
            .inspect()
            .modifier(_PresentationModifier<Presentation>.self)
            .actualView()
        
        XCTAssertEqual(modifier.presentation, presentation)
        XCTAssertEqual(modifier.destination, destination)
    }
    
    func test_registerTwoPresentations_addCorrectModifiers() throws {
        typealias Destination = TestDestination<Int>
        typealias P0 = FirstPresentation<Destination>
        typealias P1 = SecondPresentation<Destination>
        typealias Pair = PresentationPair<Destination, P0, P1>
        
        let destination = Destination(Int.self)
        let first: P0 = .init()
        let second: P1 = .init()
        
        let body = root.presentations(for: destination) {
            first
            second
        }
        
        let modifiedContent = try body
            .inspect()
            .modifier(_PresentationModifier<Pair>.self)
            .viewModifierContent()
        
        let firstModifier = try modifiedContent
            .modifier(_PresentationModifier<P0>.self)
            .actualView()
        XCTAssertEqual(firstModifier.presentation, first)
        XCTAssertEqual(firstModifier.destination, destination)
        
        let secondModifier = try modifiedContent
            .modifier(_PresentationModifier<P1>.self)
            .actualView()
        XCTAssertEqual(secondModifier.presentation, second)
        XCTAssertEqual(secondModifier.destination, destination)
    }
    
    func test_registerMultiplePresentations_addCorrectModifiers() throws {
        typealias Destination = TestDestination<Int>
        typealias P0 = FirstPresentation<Destination>
        typealias P1 = SecondPresentation<Destination>
        typealias P2 = ThirdPresentation<Destination>
        typealias InnerPair = PresentationPair<Destination, P0, P1>
        typealias OutterPair = PresentationPair<Destination, InnerPair, P2>
        
        let destination = Destination(Int.self)
        let first: P0 = .init()
        let second: P1 = .init()
        let third: P2 = .init()
        
        let body = root.presentations(for: destination) {
            first
            second
            third
        }
        
        let outterModifiedContent = try body
            .inspect()
            .modifier(_PresentationModifier<OutterPair>.self)
            .viewModifierContent()
        
        let innerModifiedContent = try outterModifiedContent
            .modifier(_PresentationModifier<InnerPair>.self)
            .viewModifierContent()
        
        let firstModifier = try innerModifiedContent
            .modifier(_PresentationModifier<P0>.self)
            .actualView()
        XCTAssertEqual(firstModifier.presentation, first)
        XCTAssertEqual(firstModifier.destination, destination)
        
        let secondModifier = try innerModifiedContent
            .modifier(_PresentationModifier<P1>.self)
            .actualView()
        XCTAssertEqual(secondModifier.presentation, second)
        XCTAssertEqual(secondModifier.destination, destination)

        let thirdModifier = try outterModifiedContent
            .modifier(_PresentationModifier<P2>.self)
            .actualView()
        XCTAssertEqual(thirdModifier.presentation, third)
        XCTAssertEqual(thirdModifier.destination, destination)
    }
}
