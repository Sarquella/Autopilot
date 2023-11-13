//
//  NavigationLink.swift
//
//
//  Created by Adrià Sarquella Farrés on 13/11/23.
//

import SwiftUI

public struct NavigationLink<Value, Label: View>: View {
    private let value: Value
    private let label: () -> Label
    
    @EnvironmentObject private var router: Router
    
    public init(
        value: Value,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.value = value
        self.label = label
    }
    
    public init(
        _ titleKey: LocalizedStringKey,
        value: Value
    ) where Label == Text {
        self.init(value: value) {
            Text(titleKey)
        }
    }
    
    public var body: some View {
        Button(
            action: {
                router.route = .init(
                    model: value,
                    style: .navigationLink
                )
            },
            label: label
        )
    }
}
