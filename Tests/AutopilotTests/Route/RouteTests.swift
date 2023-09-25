//
//  RouteTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 25/9/23.
//

import XCTest
@testable import Autopilot

class RouteTests: XCTestCase {
    func test_initWithModelAndStyle_returnsCorrectModelAndStyle() {
        let model: Int = 0
        let style: Route.Style = .sheet
        let route = Route(model: model, style: style)
        
        XCTAssertEqual(route.model as? Int, model)
        XCTAssertEqual(route.style, style)
    }
}
