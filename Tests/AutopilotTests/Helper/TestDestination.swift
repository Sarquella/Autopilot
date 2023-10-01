//
//  TestDestination.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import Autopilot
import SwiftUI

struct TestDestination<Model>: Destination {
    typealias Body = TestView<Model>
    
    private let id: TestIdentifier<Self>
    private let transform: (Any) -> Model?
    private let body: (Model) -> Body
    
    init(
        _: Model.Type,
        id: TestIdentifier<Self> = .init(),
        transform: @escaping (Any) -> Model? = { _ in nil },
        @ViewBuilder body: @escaping (Model) -> TestView<Model> = TestView<Model>.init
    ) {
        self.id = id
        self.transform = transform
        self.body = body
    }
    
    func transform(model: Any) -> Model? {
        transform(model)
    }
    
    func body(for model: Model) -> TestView<Model> {
        body(model)
    }
}

extension TestDestination: Equatable {
    static func == (lhs: TestDestination<Model>, rhs: TestDestination<Model>) -> Bool {
        lhs.id == rhs.id
    }
}
