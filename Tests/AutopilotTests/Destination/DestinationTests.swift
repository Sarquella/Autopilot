//
//  DestinationTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import XCTest
@testable import Autopilot
import SwiftUI

class DestinationTests: XCTestCase {
    typealias Destination = _Destination
    
    func test_initWithModel_returnsCorrectModel() {
        let model = Int.self
        let destination = Destination(model) { EmptyView() }
        
        XCTAssert(model == destination.model)
    }
    
    func test_initWithContent_withoutParam_returnsCorrectContent() {
        let expectedContent = TestView()
        let destination = Destination(Int.self) {
            expectedContent
        }
        
        let content = destination.content(0)
        
        XCTAssertEqual(content, expectedContent)
        XCTAssertNil(content.parameter)
    }

    func test_initWithContent_withParam_returnsCorrectContent() {
        let parameter = 0
        let destination = Destination(Int.self) { parameter in
            TestView(parameter: parameter)
        }
        
        let content = destination.content(parameter)
        
        XCTAssertEqual(content.parameter, parameter)
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
    
    func test_bodyReturnsContent() {
        let model = "model"
        let destination = Destination(String.self) { parameter in
            TestView(parameter: parameter)
        }
        
        let body = destination.body(for: model)
        guard let typedBody = body as? TestView<String> else {
            return XCTFail("Wrong body type")
        }
        XCTAssertEqual(typedBody.parameter, model)
    }
}
