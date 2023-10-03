//
//  DestinationTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
import ViewInspector

class DestinationTests: XCTestCase {
    typealias Destination = _Destination
    
    func test_initWithContent_withoutParam_returnsCorrectBody() throws {
        let content = TestView()
        let destination = Destination(Int.self) {
            content
        }
        
        let body = destination.body(for: 0)
        let typedBody = try body
            .inspect()
            .view(TestView<Void>.self)
            .actualView()
        
        XCTAssertEqual(typedBody, content)
    }

    func test_initWithContent_withParam_returnsCorrectBody() throws {
        let id: TestView<Int>.ID = .init("id")
        let parameter = 0
        let destination = Destination(Int.self) { parameter in
            TestView(
                id: id,
                parameter: parameter
            )
        }
        
        let body = destination.body(for: parameter)
        let typedBody = try body
            .inspect()
            .view(TestView<Int>.self)
            .actualView()
        
        XCTAssertEqual(typedBody.id, id)
        XCTAssertEqual(typedBody.parameter, parameter)
    }
    
    func test_transformWithInvalidModel_returnsNil() {
        let destination = Destination(String.self) { EmptyView() }
        
        let model = destination.transform(model: 0)
        
        XCTAssertNil(model)
    }
    
    func test_transformWithValidModel_returnsNil() {
        let expectedModel = "model"
        let destination = Destination(String.self) { EmptyView() }
        
        let model = destination.transform(model: expectedModel)
        
        XCTAssertEqual(model, expectedModel)
    }
    
    func test_bodyWithNilModel_returnsInvalidDestination() throws {
        let destination = Destination(String.self) {
            TestView()
        }
        
        let body = destination.body(for: nil)
        
        _ = try body
            .inspect()
            .view(InvalidDestination.self)
    }
    
    func test_bodyWithInvalidModel_returnsInvalidDestination() throws {
        let destination = Destination(String.self) {
            TestView()
        }
        
        let body = destination.body(for: 0)
        
        _ = try body
            .inspect()
            .view(InvalidDestination.self)
    }
    
    func test_bodyWithValidModel_returnsDestination() throws {
        let content = TestView()
        let destination = Destination(String.self) {
            content
        }
        
        let body = destination.body(for: "model")
        
        let typedBody = try body
            .inspect()
            .view(TestView<Void>.self)
            .actualView()
        
        XCTAssertEqual(typedBody, content)
    }
}
