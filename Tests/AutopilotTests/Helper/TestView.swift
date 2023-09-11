//
//  TestView.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import SwiftUI

struct TestView<Parameter>: View {
    let id: UUID = UUID()
    let parameter: Parameter
    
    init(parameter: Parameter) {
        self.parameter = parameter
    }
    
    init() where Parameter == Any? {
        self.parameter = nil
    }
    
    var body: some View {
        EmptyView()
    }
}

extension TestView: Equatable {
    static func == (lhs: TestView<Parameter>, rhs: TestView<Parameter>) -> Bool {
        lhs.id == rhs.id
    }
}
