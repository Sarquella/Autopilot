//
//  Binding+ModelTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 1/10/23.
//

import XCTest
@testable import Autopilot
import SwiftUI

class BindingModelTests: XCTestCase {
    func test_routeIsNil_returnsNil() {
        let binding: Binding<Route?> = .init(wrappedValue: nil)
        
        let model = binding.model
        
        XCTAssertNil(model)
    }
    
    func test_routeIsNotNil_returnsCorrectModel() {
        let expectedModel = 0
        let route = Route(model: expectedModel, style: .sheet)
        let binding: Binding<Route?> = .init(wrappedValue: route)
        
        let model = binding.model
        
        XCTAssertEqual(model as! Int, expectedModel)
    }
}
