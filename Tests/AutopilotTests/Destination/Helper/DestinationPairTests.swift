//
//  DestinationPairTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
import ViewInspector

class DestinationPairTests: XCTestCase {
    func test_initWithDestinations_returnsCorrectDestinations() {
        let first = TestDestinable(Int.self)
        let second = TestDestinable(String.self)
        let pair = DestinationPair(first: first, second: second)
        
        XCTAssertEqual(pair.first, first)
        XCTAssertEqual(pair.second, second)
    }
    
    func test_transformWithFirstModel_returnsCorrectModel() {
        let first = TestDestinable(Int.self)
        let second = TestDestinable(String.self)
        let pair = DestinationPair(first: first, second: second)
        
        let firstModel = 0
        let model = pair.transform(model: firstModel)
        
        XCTAssertEqual(model?.first, firstModel)
        XCTAssertNil(model?.second)
    }
    
    func test_transformWithSecondModel_returnsCorrectModel() {
        let first = TestDestinable(Int.self)
        let second = TestDestinable(String.self)
        let pair = DestinationPair(first: first, second: second)
        
        let secondModel = "model"
        let model = pair.transform(model: secondModel)
        
        XCTAssertNil(model?.first)
        XCTAssertEqual(model?.second, secondModel)
    }
    
    func test_transformWithInvalidModel_returnsNil() {
        let first = TestDestinable(Int.self)
        let second = TestDestinable(String.self)
        let pair = DestinationPair(first: first, second: second)
        
        let model = pair.transform(model: true)
        
        XCTAssertNil(model)
    }
    
    func test_bodyWithFirstModel_returnsFirstBody() throws {
        let first = TestDestinable(Int.self, body: TestView.init)
        let second = TestDestinable(String.self, body: TestView.init)
        let pair = DestinationPair(first: first, second: second)
        
        let model = 0
        let body = pair.body(for: .init(first: model, second: nil))
        let view = try body
            .inspect()
            .view(TestView<Int>.self)
            .actualView()
        
        XCTAssertEqual(view.parameter, model)
    }
    
    func test_bodyWithSecondModel_returnsSecondBody() throws {
        let first = TestDestinable(Int.self, body: TestView.init)
        let second = TestDestinable(String.self, body: TestView.init)
        let pair = DestinationPair(first: first, second: second)
        
        let model = "model"
        let body = pair.body(for: .init(first: nil, second: model))
        let view = try body
            .inspect()
            .view(TestView<String>.self)
            .actualView()
        
        XCTAssertEqual(view.parameter, model)
    }
    
    func test_bodyWithInvalidModel_returnsInvalidDestination() throws {
        let first = TestDestinable(Int.self, body: TestView.init)
        let second = TestDestinable(String.self, body: TestView.init)
        let pair = DestinationPair(first: first, second: second)
        
        let body = pair.body(for: .init(first: nil, second: nil))
        _ = try body
            .inspect()
            .view(InvalidDestination.self)
    }
}
