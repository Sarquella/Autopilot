//
//  TestDestinable.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import Autopilot
import SwiftUI

struct TestDestinable<Model, Body: View>: Destinable {
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

extension TestDestinable: Equatable {
    static func == (lhs: TestDestinable<Model, Body>, rhs: TestDestinable<Model, Body>) -> Bool {
        lhs.id == rhs.id
    }
}
