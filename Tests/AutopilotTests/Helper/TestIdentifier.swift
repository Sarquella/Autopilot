//
//  TestIdentifier.swift
//  
//
//  Created by Adrià Sarquella Farrés on 1/10/23.
//

import Foundation

struct TestIdentifier<Holder>: Hashable {
    let value: String
    
    init(_ value: String = UUID().uuidString) {
        self.value = value
    }
}
