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
    private let body: (Model) -> Body
    
    init(
        _: Model.Type,
        id: String = "\(Model.self)",
        @ViewBuilder body: @escaping (Model) -> Body
    ) {
        self.id = id
        self.body = body
    }
    
    init(
        _ model: Model.Type,
        id: String = "\(Model.self)"
    ) where Body == EmptyView {
        self.init(
            model,
            id: id
        ) { _ in
            EmptyView()
        }
    }
    
    func transform(model: Any) -> Model? {
        nil
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
