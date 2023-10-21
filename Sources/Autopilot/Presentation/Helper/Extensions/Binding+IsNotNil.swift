//
//  Binding+IsNotNil.swift
//  
//
//  Created by Adrià Sarquella Farrés on 25/9/23.
//

import SwiftUI

extension Binding {
    func isNotNil<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
        .init(
            get: {
                wrappedValue != nil
            },
            set: {
                wrappedValue = $0 ? wrappedValue : nil
            }
        )
    }
}
