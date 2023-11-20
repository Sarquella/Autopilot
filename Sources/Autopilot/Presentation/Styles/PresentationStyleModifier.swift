//
//  PresentationStyleModifier.swift
//
//
//  Created by Adrià Sarquella Farrés on 22/10/23.
//

import SwiftUI

struct PresentationStyleModifier<Item>: ViewModifier {
    @Binding var item: Item?
    let style: Route.Style
    let onDismiss: (() -> Void)?
    
    @EnvironmentObject private var router: Router
    
    func body(content: Content) -> some View {
        content
            .onChange(of: item == nil) { _ in
                router.route = item.map {
                    .init(model: $0, style: style)
                }
            }
            .onChange(of: router.route == nil) { isDismissed in
                if isDismissed {
                    item = nil
                    onDismiss?()
                }
            }
    }
}
