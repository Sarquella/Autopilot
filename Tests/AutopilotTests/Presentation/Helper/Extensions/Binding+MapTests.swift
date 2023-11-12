//
//  Binding+MapTests.swift
//
//
//  Created by Adrià Sarquella Farrés on 12/11/23.
//

import XCTest
@testable import Autopilot
import SwiftUI

class BindingMapTests: XCTestCase {
    func test_valueIsFalse_returnsNil() {
        let binding: Binding<Bool> = .init(wrappedValue: false)
        
        let mapped = binding.map(to: "item")
                
        XCTAssertNil(mapped.wrappedValue)
    }
    
    func test_valueTrue_returnsItem() {
        let binding: Binding<Bool> = .init(wrappedValue: true)
        
        let item = "item"
        let mapped = binding.map(to: item)
                
        XCTAssertEqual(mapped.wrappedValue, item)
    }
    
    func test_valueUpdatesToNil_updatesOriginalBindingToFalse() {
        let binding: Binding<Bool> = .init(wrappedValue: true)
        
        let mapped = binding.map(to: "item")
        mapped.wrappedValue = nil
                
        XCTAssertFalse(binding.wrappedValue)
    }
    
    func test_valueUpdatesToNotNil_updatesOriginalBindingToTrue() {
        let binding: Binding<Bool> = .init(wrappedValue: false)
        
        let mapped = binding.map(to: "item")
        mapped.wrappedValue = "item"
        
        XCTAssertTrue(binding.wrappedValue)
    }
}
