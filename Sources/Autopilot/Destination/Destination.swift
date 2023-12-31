//
//  Destination.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import SwiftUI

public protocol Destination {
    associatedtype Body: View
    associatedtype Model
    func transform(model: Any) -> Self.Model?
    @ViewBuilder func body(for model: Self.Model) -> Self.Body
}

extension Destination {
    @ViewBuilder
    func body(for model: Any?) -> some View {
        if let model,
           let typedModel = transform(model: model) {
            body(for: typedModel)
        } else {
            InvalidDestination()
        }
    }
}

@available(*, deprecated, renamed: "Destination")
public struct _Destination<Model, Content: View> {
    private let model: Model.Type
    private let content: (Model) -> Content
        
    public init(
        _ model: Model.Type,
        @ViewBuilder content: @escaping (Model) -> Content
    ) {
        self.model = model
        self.content = content
    }
    
    public init(
        _ model: Model.Type,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(model) { _ in content() }
    }
}

extension _Destination: Destination {
    public func transform(model: Any) -> Model? {
        model as? Model
    }
    
    public func body(for model: Model) -> some View {
        content(model)
    }
}
