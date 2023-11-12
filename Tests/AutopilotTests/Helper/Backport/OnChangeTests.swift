//
//  OnChangeTests.swift
//
//
//  Created by Adrià Sarquella Farrés on 22/10/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
import ViewInspector

class OnChangeTests: XCTestCase {
    let initialValue = "value"
    var updatedValue: String?
    
    func launchView(
        onAppear: @escaping (Binding<String>) -> Void = { _ in }
    ) {
        let view = OnChangeView(
            value: initialValue,
            action: { self.updatedValue = $0 },
            onAppear: onAppear
        )
        ViewHosting.host(view: view)
    }
    
    func test_beforeValueUpdate_actionIsNotCalled() {
        launchView()
        XCTAssertNil(updatedValue)
    }
    
    func test_afterValueUpdate_ifValueDidNotChange_actionIsNotCalled() {
        launchView {
            $0.wrappedValue = self.initialValue
        }
        XCTAssertNil(updatedValue)
    }
    
    func test_afterValueUpdate_ifValueDidChange_actionIsCalled() throws {
        let newValue = "newValue"
        launchView {
            $0.wrappedValue = newValue
        }
        XCTAssertEqual(updatedValue, newValue)
    }
}

extension OnChangeTests {
    struct OnChangeView: View {
        @State var value: String
        let action: (String) -> Void
        let onAppear: ((Binding<String>) -> Void)
        
        var body: some View {
            Color.clear
                .onChange(
                    of: value,
                    perform: action
                )
                .onAppear {
                    onAppear($value)
                }
        }
    }
}
