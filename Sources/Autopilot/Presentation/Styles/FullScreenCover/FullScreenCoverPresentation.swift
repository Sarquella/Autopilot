//
//  FullScreenCoverPresentation.swift
//  
//
//  Created by Adrià Sarquella Farrés on 4/10/23.
//

import SwiftUI

struct FullScreenCoverPresentation<Presentable: Destination>: Presentation {
    func body(
        root: Root,
        route: Binding<Route?>,
        destination: Presentable
    ) -> some View {
        if #available(
            iOS 14.0,
            macOS 11.0,
            tvOS 14.0,
            watchOS 7.0,
            *
        ) {
            root
                #if os(iOS) || os(tvOS) || os(watchOS)
                .modifier(
                    FullScreenCoverPresentationModifier(
                        isPresented: route
                            .filter(by: .fullScreenCover)
                            .filter(by: destination)
                            .isNotNil(),
                        fullScreenCover: { destination.body(for: route.model) }
                    )
                )
                #endif
        } else {
            root
        }
    }
}

/*
 Dedicated ViewModifier for proper testing access.
 See more: https://github.com/nalexn/ViewInspector/blob/master/guide_popups.md#fullscreencover
 */
@available(macOS, unavailable)
@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
struct FullScreenCoverPresentationModifier<FullScreenCover: View>: ViewModifier {
    let isPresented: Binding<Bool>
    @ViewBuilder var fullScreenCover: () -> FullScreenCover
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(
                isPresented: isPresented,
                content: fullScreenCover
            )
    }
}
