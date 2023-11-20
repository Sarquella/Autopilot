//
//  View+SheetPresentationTests.swift
//
//
//  Created by Adrià Sarquella Farrés on 12/11/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
import ViewInspector

class ViewSheetPresentationTests: XCTestCase {
    typealias Root = TestView<Void>
    typealias Item = String
    
    func testSheetModifier<Content: View>(
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
        XCTAssertEqual(modifier.style, .sheet)
        XCTAssertFalse(didDismiss)
        modifier.onDismiss?()
        XCTAssertTrue(didDismiss)
    }
}

// MARK: item
extension ViewSheetPresentationTests {
    func test_sheetWithItem_whenIsNil_addsCorrectModifier() throws {
        try testSheetModifier(item: nil) { root, onDismiss in
            root
                .sheet(
                    item: Binding<Item?>.constant(nil),
                    onDismiss: onDismiss
                )
        }
    }
    
    func test_sheetWithItem_whenIsNotNil_addsCorrectModifier() throws {
        let item = "item"
        try testSheetModifier(item: item) { root, onDismiss in
            root
                .sheet(
                    item: .constant(item),
                    onDismiss: onDismiss
                )
        }
    }
}

// MARK: isPresented
extension ViewSheetPresentationTests {
    func test_sheetWithIsPresented_whenIsFalse_addsCorrectModifier() throws {
        try testSheetModifier(item: nil) { root, onDismiss in
            root
                .sheet(
                    isPresented: .constant(false),
                    item: "item",
                    onDismiss: onDismiss
                )
        }
    }
    
    func test_sheetWithIsPresented_whenIsTrue_addsCorrectModifier() throws {
        let item = "item"
        try testSheetModifier(item: item) { root, onDismiss in
            root
                .sheet(
                    isPresented: .constant(true),
                    item: item,
                    onDismiss: onDismiss
                )
        }
    }
}
