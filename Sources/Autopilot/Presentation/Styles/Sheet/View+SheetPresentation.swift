//
//  View+SheetPresentation.swift
//
//
//  Created by Adrià Sarquella Farrés on 12/11/23.
//

import SwiftUI

public extension View {
    func sheet<Item>(
        item: Binding<Item?>,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        modifier(
            PresentationStyleModifier(
                item: item,
                style: .sheet,
                onDismiss: onDismiss
            )
        )
    }
    
    func sheet<Item>(
        isPresented: Binding<Bool>,
        item: Item,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        sheet(
            item: isPresented.map(to: item),
            onDismiss: onDismiss
        )
    }
}
