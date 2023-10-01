//
//  TestIdentifier.swift
//  
//
//  Created by Adrià Sarquella Farrés on 1/10/23.
//

struct TestIdentifier<Holder>: Equatable {
    let value: String
    
    init(_ value: String) {
        self.value = value
    }
}
