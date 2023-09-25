//
//  RouterTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 25/9/23.
//

import XCTest
@testable import Autopilot

class RouterTests: XCTestCase {
    func test_init_returnsNilRoute() {
        let router = Router()
        
        XCTAssertNil(router.route)
    }
    
    func test_updatesRoute_returnsCorrectRoute() {
        let route = Route(
            model: "model",
            style: .navigationLink
        )
        let router = Router()
        
        router.route = route
        
        XCTAssertEqual(router.route?.model as? String, route.model as? String)
        XCTAssertEqual(router.route?.style, route.style)
    }
}
