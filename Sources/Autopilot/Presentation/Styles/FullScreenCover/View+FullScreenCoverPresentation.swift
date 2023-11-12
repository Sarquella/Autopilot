//
//  View+FullScreenCoverPresentation.swift
//
//
//  Created by Adrià Sarquella Farrés on 12/11/23.
//

import SwiftUI

public extension View {
    func fullScreenCover<Item>(
        item: Binding<Item?>,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        modifier(
            PresentationStyleModifier(
                item: item,
                style: .fullScreenCover,
                onDismiss: onDismiss
            )
        )
    }
    
    func fullScreenCover<Item>(
        isPresented: Binding<Bool>,
        item: Item,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        fullScreenCover(
            item: isPresented.map(to: item),
            onDismiss: onDismiss
        )
    }
}
