//
//  NavigationLinkPresentation.swift
//  
//
//  Created by Adrià Sarquella Farrés on 19/10/23.
//

import SwiftUI

struct NavigationLinkPresentation<Presentable: Destination>: Presentation {
    func body(
        root: Root,
        route: Binding<Route?>,
        destination: Presentable
    ) -> some View {
        root.background(
            SwiftUI.NavigationLink(
                isActive: route
                    .filter(by: .navigationLink)
                    .filter(by: destination)
                    .isNotNil()
                ,
                destination: {
                    destination.body(for: route.model)
                },
                label: EmptyView.init
            )
        )
    }
}
