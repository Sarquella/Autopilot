//
//  View+Presentation.swift
//  
//
//  Created by Adrià Sarquella Farrés on 1/10/23.
//

import SwiftUI

extension View {
    func presentations<Presentable: Destination>(
        for destination: Presentable,
        @PresentationBuilder presentations: @escaping () -> some Presentation<Presentable>
    ) -> some View {
        modifier(
            _PresentationModifier(
                presentation: presentations(),
                destination: destination
            )
        )
    }
}
