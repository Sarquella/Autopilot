//
//  TestView.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import SwiftUI

struct TestView<Parameter>: View {
    let parameter: Parameter
    
    init(parameter: Parameter) {
        self.parameter = parameter
    }
    
    init() where Parameter == String? {
        self.init(parameter: nil)
    }
    
    var body: some View {
        EmptyView()
    }
}

extension TestView: Equatable where Parameter: Equatable {
    static func == (lhs: TestView<Parameter>, rhs: TestView<Parameter>) -> Bool {
        lhs.parameter == rhs.parameter
    }
}
