//
//  SheetPresentation.swift
//  
//
//  Created by Adrià Sarquella Farrés on 30/9/23.
//

import SwiftUI

struct SheetPresentation<Presentable: Destination>: Presentation {
    func body(
        root: Root,
        route: Binding<Route?>,
        destination: Presentable
    ) -> some View {
        root.modifier(
            SheetPresentationModifier(
                isPresented: route
                    .filter(by: .sheet)
                    .filter(by: destination)
                    .isNotNil(),
                sheet: { destination.body(for: route.model) }
            )
        )
    }
}

/*
 Dedicated ViewModifier for proper testing access.
 See more: https://github.com/nalexn/ViewInspector/blob/master/guide_popups.md#sheet
 */
struct SheetPresentationModifier<Sheet: View>: ViewModifier {
    let isPresented: Binding<Bool>
    @ViewBuilder var sheet: () -> Sheet
    
    func body(content: Content) -> some View {
        content
            .sheet(
                isPresented: isPresented,
                content: sheet
            )
    }
}
