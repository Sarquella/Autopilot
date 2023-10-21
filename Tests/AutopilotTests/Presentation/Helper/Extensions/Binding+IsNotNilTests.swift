//
//  Binding+IsNotNilTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 25/9/23.
//

import XCTest
@testable import Autopilot
import SwiftUI

class BindingIsNotNilTests: XCTestCase {
    func test_valueIsNil_returnsFalse() {
        let binding: Binding<Int?> = .init(wrappedValue: nil)
        
        let isNotNil = binding.isNotNil()
                
        XCTAssertFalse(isNotNil.wrappedValue)
    }
    
    func test_valueIsNotNil_returnsTrue() {
        let binding: Binding<Int?> = .init(wrappedValue: 0)
        
        let isNotNil = binding.isNotNil()
                
        XCTAssertTrue(isNotNil.wrappedValue)
    }
    
    func test_valueUpdatesToFalse_updatesOriginalBindingToNil() {
        let binding: Binding<Int?> = .init(wrappedValue: 0)
        
        let isNotNil = binding.isNotNil()
        isNotNil.wrappedValue = false
                
        XCTAssertNil(binding.wrappedValue)
    }
    
    func test_valueUpdatesToTrue_keepsOriginalBinding() {
        let value = 0
        let binding: Binding<Int?> = .init(wrappedValue: value)
        
        let isNotNil = binding.isNotNil()
        isNotNil.wrappedValue = true
        
        XCTAssertEqual(binding.wrappedValue, value)
    }
}
