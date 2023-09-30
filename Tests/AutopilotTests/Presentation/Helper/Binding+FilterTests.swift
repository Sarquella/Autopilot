//
//  Binding+FilterTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 25/9/23.
//

import XCTest
@testable import Autopilot
import SwiftUI

class BindingFilterTests: XCTestCase {
    let destination = TestDestination(
        Int.self,
        transform: { $0 as? Int }
    )
}

// MARK: Style
extension BindingFilterTests {
    func test_filterByStyle_whenRouteIsNil_returnsNil() {
        let binding: Binding<Route?> = .init(wrappedValue: nil)
        
        let filtered = binding.filter(by: .sheet).wrappedValue
        
        XCTAssertNil(filtered)
    }
    
    func test_filterByStyle_whenStyleIsUnsupported_returnsNil() {
        let route = Route(model: 0, style: .navigationLink)
        let binding: Binding<Route?> = .init(wrappedValue: route)
        
        let filtered = binding.filter(by: .sheet).wrappedValue
        
        XCTAssertNil(filtered)
    }
    
    func test_filterByStyle_whenStyleIsSupported_returnsValue() {
        let model = 0
        let style: Route.Style = .sheet
        let route = Route(model: model, style: style)
        let binding: Binding<Route?> = .init(wrappedValue: route)
        
        let filtered = binding.filter(by: style).wrappedValue
        
        XCTAssertEqual(filtered?.model as! Int, model)
        XCTAssertEqual(filtered?.style, style)
    }
    
    func test_filterByStyle_whenModelIsUpdatedToNil_updatesOriginalBindingToNil() {
        let binding: Binding<Route?> = .init(
            wrappedValue: .init(model: 0, style: .sheet)
        )
        
        let filtered = binding.filter(by: .sheet)
        filtered.wrappedValue = nil
        
        XCTAssertNil(binding.wrappedValue)
    }
    
    func test_filterByStyle_whenModelIsUpdated_withUnsupportedStyle_keepsOriginalBinding() {
        let model = 0
        let style: Route.Style = .sheet
        let binding: Binding<Route?> = .init(
            wrappedValue: .init(model: model, style: style)
        )
        
        let filtered = binding.filter(by: style)
        filtered.wrappedValue = .init(model: 1, style: .navigationLink)
        
        XCTAssertEqual(binding.wrappedValue?.model as! Int, model)
        XCTAssertEqual(binding.wrappedValue?.style, style)
    }
    
    func test_filterByStyle_whenModelIsUpdated_withSupportedStyle_updatesOriginalBinding() {
        let style: Route.Style = .sheet
        let binding: Binding<Route?> = .init(
            wrappedValue: .init(model: 0, style: style)
        )
        
        let filtered = binding.filter(by: style)
        let newValue = 1
        filtered.wrappedValue = .init(model: newValue, style: style)
        
        XCTAssertEqual(binding.wrappedValue?.model as! Int, newValue)
        XCTAssertEqual(binding.wrappedValue?.style, style)
    }
}

// MARK: Destination
extension BindingFilterTests {
    func test_filterByDestination_whenRouteIsNil_returnsNil() {
        let binding: Binding<Route?> = .init(wrappedValue: nil)
        
        let filtered = binding.filter(by: destination).wrappedValue
        
        XCTAssertNil(filtered)
    }
    
    func test_filterByDestination_whenRouteIsUnsupported_returnsNil() {
        let route = Route(model: "model", style: .sheet)
        let binding: Binding<Route?> = .init(wrappedValue: route)
        
        let filtered = binding.filter(by: destination).wrappedValue
        
        XCTAssertNil(filtered)

    }
    
    func test_filterByDestination_whenRouteIsSupported_returnsRoute() {
        let route = Route(model: 0, style: .sheet)
        let binding: Binding<Route?> = .init(wrappedValue: route)
        
        let filtered = binding.filter(by: destination).wrappedValue
        
        XCTAssertEqual(filtered?.model as! Int, route.model as! Int)
        XCTAssertEqual(filtered?.style, route.style)
    }
    
    func test_filterByDestination_whenRouteIsUpdated_updatesOriginalBinding() {
        let route = Route(model: 0, style: .sheet)
        let binding: Binding<Route?> = .init(wrappedValue: nil)
        
        let filtered = binding.filter(by: destination)
        filtered.wrappedValue = route
        
        XCTAssertEqual(binding.wrappedValue?.model as! Int, route.model as! Int)
        XCTAssertEqual(binding.wrappedValue?.style, route.style)
    }
}
