//
//  SheetPresentationTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 2/10/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
import ViewInspector

class SheetPresentationTests: XCTestCase {
    func testSheet(
        for route: Route?,
        isPresented: Bool
    ) throws {
        typealias Model = Int
        typealias Sheet = TestView<Model>
        typealias Destination = _Destination<Model, Sheet>
        typealias Root = TestView<Void>
        
        let sheetId: Sheet.ID = .init("sheetId")
        let destination = Destination(Model.self) { parameter in
            Sheet(
                id: sheetId,
                parameter: parameter
            )
        }
        
        let router = Router()
        router.route = route
        
        let body = Root()
            .presentations(for: destination) {
                SheetPresentation<Destination>()
            }
            .environmentObject(router)
        
        let sheet = try? body
            .inspect()
            .view(Root.self)
            .sheet()
        
        if isPresented {
            let sheetBody = try XCTUnwrap(sheet)
                .find(Sheet.self)
                .actualView()
            XCTAssertEqual(sheetBody.id, sheetId)
            XCTAssertEqual(sheetBody.parameter, route?.model as! Model)
        } else {
            XCTAssertNil(sheet)
        }
    }
    
    func test_routeIsNil_sheetIsNotPresented() throws {
        try testSheet(
            for: nil,
            isPresented: false
        )
    }
    
    func test_routeHasInvalidStyle_sheetIsNotPresented() throws {
        try testSheet(
            for: .init(model: 0, style: .fullScreenCover),
            isPresented: false
        )
    }
    
    func test_routeHasInvalidModel_sheetIsNotPresented() throws {
        try testSheet(
            for: .init(model: "invalid", style: .sheet),
            isPresented: false
        )
    }
    
    func test_routeIsValid_sheetIsPresented() throws {
        try testSheet(
            for: .init(model: 0, style: .sheet),
            isPresented: true
        )
    }
}

extension SheetPresentationModifier: PopupPresenter {
    public typealias Popup = Sheet
    public var popupBuilder: () -> Sheet { sheet }
    public var onDismiss: (() -> Void)? { nil }
}
