//
//  Environment+RouterTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 25/9/23.
//

import XCTest
@testable import Autopilot
import SwiftUI

class EnvironmentRouterTests: XCTestCase {
    func test_init_returnsDefaultRouter() {
        let environment = EnvironmentValues()
        let router = environment.router
        
        XCTAssertNil(router.route)
    }
    
    func test_updatesRouter_returnsCorrectRouter() {
        let router = Router()
        var environment = EnvironmentValues()
        
        environment.router = router
        
        XCTAssertTrue(environment.router === router)
    }
}
