//
//  Presentation.swift
//  
//
//  Created by Adrià Sarquella Farrés on 25/9/23.
//

import SwiftUI

protocol Presentation<Destination> {
    associatedtype Body: View
    associatedtype Destination: Destinable
    typealias Root = _PresentationModifier<Self>.Content
    
    @ViewBuilder @MainActor func body(
        root: Self.Root,
        route: Binding<Route?>,
        destination: Self.Destination
    ) -> Self.Body
}

struct _PresentationModifier<P: Presentation>: ViewModifier {
    let presentation: P
    let destination: P.Destination
    
    @EnvironmentObject private var router: Router
    
    fileprivate init(
        presentation: P,
        destination: P.Destination
    ) {
        self.presentation = presentation
        self.destination = destination
    }
    
    func body(content: Content) -> some View {
        presentation.body(
            root: content,
            route: $router.route,
            destination: destination
        )
    }
}
