//
//  Binding+Filter.swift
//  
//
//  Created by Adrià Sarquella Farrés on 25/9/23.
//

import SwiftUI

extension Binding where Value == Route? {
    func filter(by style: Route.Style) -> Binding<Value> {
        .init(
            get: {
                wrappedValue?.style == style ? wrappedValue : nil
            },
            set: { value in
                guard value == nil || value?.style == style else {
                    return
                }
                wrappedValue = value
            }
        )
    }
    
    func filter<D: Destination>(by destination: D) -> Binding<Value> {
        .init(
            get: {
                wrappedValue.flatMap { route in
                    destination.transform(model: route.model).map { _ in
                        route
                    }
                }
            },
            set: {
                wrappedValue = $0
            }
        )
    }
}
