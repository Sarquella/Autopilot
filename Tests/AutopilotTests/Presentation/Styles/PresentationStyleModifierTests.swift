//
//  PresentationStyleModifierTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 12/11/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
import ViewInspector

class PresentationStyleModifierTests: XCTestCase {
    var router: Router!
    let style: Route.Style = .fullScreenCover
    var didDismiss: Bool!
    
    override func setUp() {
        router = .init()
        didDismiss = false
    }
    
    func launchView(
        item: String? = nil,
        route: Route? = nil,
        onAppear: @escaping (Binding<String?>) -> Void = { _ in }
    ) throws {
        router.route = route
        let view = PresentationStyleView(
            item: item,
            style: style,
            onDismiss: { self.didDismiss = true },
            onAppear: onAppear
        ).environmentObject(router)
        try ViewHosting.host(view: view)
    }
}

// MARK: Route
extension PresentationStyleModifierTests {
    func test_beforeItemUpdate_routerIsNotUpdated() throws {
        try launchView()
        XCTAssertNil(router.route)
    }
    
    func test_afterItemUpdate_ifIsChangedFromNilToNotNil_routerIsUpdatedWithItem() throws {
        let newItem = "newItem"
        try launchView(item: nil) { item in
            item.wrappedValue = newItem
        }
        XCTAssertEqual(router.route?.model as! String, newItem)
        XCTAssertEqual(router.route?.style, style)
    }
    
    func test_afterItemUpdate_ifIsChangedFromNotNilToNil_routerIsUpdatedWithNil() throws {
        try launchView(item: "item") { item in
            item.wrappedValue = nil
        }
        XCTAssertNil(router.route)
    }
}

// MARK: Dismiss
extension PresentationStyleModifierTests {
    func test_beforeRouteUpdate_onDismissIsNotCalled() throws {
        try launchView()
        XCTAssertFalse(didDismiss)
    }
    
    func test_afterRouteUpdate_ifIsChangedFromNilToNotNil_onDismissIsNotCalled() throws {
        try launchView(route: nil) { [self] _ in
            router.route = .init(model: "model", style: style)
        }
        XCTAssertFalse(didDismiss)
    }
    
    func test_afterItemUpdate_ifIsChangedFromNotNilToNil_onDismissIsCalled() throws {
        try launchView(route: .init(model: "model", style: style)) { [self] _ in
            router.route = nil
        }
        XCTAssertTrue(didDismiss)
    }
}

private extension PresentationStyleModifierTests {
    struct PresentationStyleView: View {
        @State var item: String?
        let style: Route.Style
        let onDismiss: () -> Void
        let onAppear: (Binding<String?>) -> Void
        
        var body: some View {
            Color.clear
                .modifier(
                    PresentationStyleModifier(
                        item: $item,
                        style: style,
                        onDismiss: onDismiss
                    )
                )
                .onAppear {
                    onAppear($item)
                }
        }
    }
}
