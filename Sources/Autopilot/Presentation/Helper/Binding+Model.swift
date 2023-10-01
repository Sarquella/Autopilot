//
//  Binding+Model.swift
//  
//
//  Created by Adrià Sarquella Farrés on 1/10/23.
//

import SwiftUI

extension Binding where Value == Route? {
    var model: Route.Model? {
        wrappedValue?.model
    }
}
