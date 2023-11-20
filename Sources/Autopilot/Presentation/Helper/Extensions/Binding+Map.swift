//
//  Binding+Map.swift
//  
//
//  Created by Adrià Sarquella Farrés on 12/11/23.
//

import SwiftUI

extension Binding where Value == Bool {
    func map<Item>(to item: Item) -> Binding<Item?> where Value == Bool {
        .init(
            get: {
                wrappedValue ? item : nil
            },
            set: { newItem in
                wrappedValue = newItem != nil
            }
        )
    }
}
