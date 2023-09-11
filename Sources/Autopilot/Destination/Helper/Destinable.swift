//
//  Destinable.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import SwiftUI

public protocol Destinable {
    associatedtype Body: View
    associatedtype Model
    func transform(model: Any) -> Self.Model?
    @ViewBuilder func body(for model: Self.Model) -> Self.Body
}
