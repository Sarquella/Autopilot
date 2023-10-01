//
//  TestPresentation.swift
//  
//
//  Created by Adrià Sarquella Farrés on 1/10/23.
//

@testable import Autopilot
import SwiftUI

protocol TestPresentation: Presentation, Equatable
where Body == EmptyView {
    var id: TestIdentifier<Self> { get }
    init(id: TestIdentifier<Self>)
}

extension TestPresentation {
    init() {
        self.init(
            id: .init()
        )
    }
    
    func body(
        root: Root,
        route: Binding<Route?>,
        destination: Presentable
    ) -> EmptyView {
        EmptyView()
    }
}

struct FirstPresentation<Presentable: Destination>: TestPresentation {
    let id: TestIdentifier<Self>
}
struct SecondPresentation<Presentable: Destination>: TestPresentation {
    let id: TestIdentifier<Self>
}
struct ThirdPresentation<Presentable: Destination>: TestPresentation {
    let id: TestIdentifier<Self>
}
