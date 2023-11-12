//
//  OnChange.swift
//
//
//  Created by Adrià Sarquella Farrés on 22/10/23.
//

import SwiftUI
import Combine

extension View {
    @ViewBuilder
    @_disfavoredOverload
    func onChange<Value: Equatable>(
        of value: Value,
        perform action: @escaping (Value) -> Void
    ) -> some View {
        if #available(iOS 14, macOS 11, tvOS 14, watchOS 7, *) {
            onChange(
                of: value,
                perform: action
            )
        } else {
            modifier(
                OnChangeModifier(
                    value: value,
                    action: action
                )
            )
        }
    }
}

// Implements `onChange` modifier behavior for older OS versions
private struct OnChangeModifier<Value: Equatable>: ViewModifier {
    let value: Value
    let action: (Value) -> Void

    @State private var oldValue: Value?

    init(
        value: Value,
        action: @escaping (Value) -> Void
    ) {
        self.value = value
        self.action = action
        _oldValue = .init(initialValue: value)
    }

    func body(content: Content) -> some View {
        content
            .onReceive(Just(value)) { newValue in
                guard newValue != oldValue else { return }
                action(newValue)
                oldValue = newValue
            }
    }
}
