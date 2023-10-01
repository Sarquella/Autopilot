//
//  TestView.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import SwiftUI
import XCTest

struct TestView<Parameter>: View {
    let id: TestIdentifier<Self>
    let parameter: Parameter
    
    init(
        id: TestIdentifier<Self>,
        parameter: Parameter
    ) {
        self.id = id
        self.parameter = parameter
    }
    
    init(parameter: Parameter) {
        self.init(
            id: .init(),
            parameter: parameter
        )
    }
    
    init(id: TestIdentifier<Self>) where Parameter == Void {
        self.init(
            id: id,
            parameter: ()
        )
    }
    
    init() where Parameter == Void {
        self.init(
            id: .init(),
            parameter: ()
        )
    }
    
    var body: some View {
        EmptyView()
    }
}

extension TestView: Equatable {
    static func == (lhs: TestView<Parameter>, rhs: TestView<Parameter>) -> Bool {
        lhs.id == rhs.id
    }
    
    static func == (
        lhs: TestView<Parameter>,
        rhs: TestView<Parameter>
    ) -> Bool where Parameter: Equatable {
        lhs.id == rhs.id && lhs.parameter == rhs.parameter
    }
}
