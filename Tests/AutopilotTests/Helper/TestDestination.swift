//
//  TestDestination.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import Autopilot
import SwiftUI

struct TestDestination<Model, Body: View>: Destination {
    private let id: String
    private let transform: (Any) -> Model?
    private let body: (Model) -> Body
    
    init(
        _: Model.Type,
        id: String = "\(Model.self)",
        transform: @escaping (Any) -> Model? = { _ in nil },
        @ViewBuilder body: @escaping (Model) -> Body
    ) {
        self.id = id
        self.transform = transform
        self.body = body
    }
    
    init(
        _ model: Model.Type,
        id: String = "\(Model.self)",
        transform: @escaping (Any) -> Model? = { _ in nil }
    ) where Body == EmptyView {
        self.init(
            model,
            id: id,
            transform: transform
        ) { _ in
            EmptyView()
        }
    }
    
    func transform(model: Any) -> Model? {
        transform(model)
    }
    
    func body(for model: Model) -> some View {
        body(model)
    }
}

extension TestDestination: Equatable {
    static func == (lhs: TestDestination<Model, Body>, rhs: TestDestination<Model, Body>) -> Bool {
        lhs.id == rhs.id
    }
}
