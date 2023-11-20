//
//  View+FullScreenCoverPresentationTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 12/11/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
import ViewInspector

class ViewFullScreenCoverPresentationTests: XCTestCase {
    typealias Root = TestView<Void>
    typealias Item = String
    
    func testFullScreenCoverModifier<Content: View>(
        item: Item?,
        content: (Root, @escaping () -> Void) -> Content
    ) throws {
        var didDismiss = false
        let view = content(
            Root(),
            { didDismiss = true }
        )
        
        let modifier = try view
            .inspect()
            .modifier(PresentationStyleModifier<Item>.self)
            .actualView()
        
        XCTAssertEqual(modifier.item, item)
        XCTAssertEqual(modifier.style, .fullScreenCover)
        XCTAssertFalse(didDismiss)
        modifier.onDismiss?()
        XCTAssertTrue(didDismiss)
    }
}

// MARK: item
extension ViewFullScreenCoverPresentationTests {
    func test_fullScreenCoverWithItem_whenIsNil_addsCorrectModifier() throws {
        try testFullScreenCoverModifier(item: nil) { root, onDismiss in
            root
                .fullScreenCover(
                    item: Binding<Item?>.constant(nil),
                    onDismiss: onDismiss
                )
        }
    }
    
    func test_fullScreenCoverWithItem_whenIsNotNil_addsCorrectModifier() throws {
        let item = "item"
        try testFullScreenCoverModifier(item: item) { root, onDismiss in
            root
                .fullScreenCover(
                    item: .constant(item),
                    onDismiss: onDismiss
                )
        }
    }
}

// MARK: isPresented
extension ViewFullScreenCoverPresentationTests {
    func test_fullScreenCoverWithIsPresented_whenIsFalse_addsCorrectModifier() throws {
        try testFullScreenCoverModifier(item: nil) { root, onDismiss in
            root
                .fullScreenCover(
                    isPresented: .constant(false),
                    item: "item",
                    onDismiss: onDismiss
                )
        }
    }
    
    func test_fullScreenCoverWithIsPresented_whenIsTrue_addsCorrectModifier() throws {
        let item = "item"
        try testFullScreenCoverModifier(item: item) { root, onDismiss in
            root
                .fullScreenCover(
                    isPresented: .constant(true),
                    item: item,
                    onDismiss: onDismiss
                )
        }
    }
}
