//
//  NavigationLinkPresentationTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 19/10/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
@testable import ViewInspector

class NavigationLinkPresentationTests: XCTestCase {
    func testNavigationLink(
        for route: Route?,
        isPresented: Bool
    ) throws {
        typealias Model = Int
        typealias PushedContent = TestView<Model>
        typealias Destination = _Destination<Model, PushedContent>
        typealias Root = TestView<Void>
        
        let pushedContentId: PushedContent.ID = .init("pushedContentId")
        let destination = Destination(Model.self) { parameter in
            PushedContent(
                id: pushedContentId,
                parameter: parameter
            )
        }
        
        let router = Router()
        router.route = route
        
        let body = Root()
            .presentations(for: destination) {
                NavigationLinkPresentation<Destination>()
            }
            .environmentObject(router)
        
        let navigationLink = try body
            .inspect()
            .view(Root.self)
            .modifier(
                _PresentationModifier<NavigationLinkPresentation<Destination>>.self
            )
            .viewModifierContent()
            .background()
            .navigationLink()
        
        _ = try navigationLink
            .labelView()
            .emptyView()
        
        let pushedContent = try? navigationLink
            .find(PushedContent.self)
            .actualView()
        
        if isPresented {
            let pushedBody = try XCTUnwrap(pushedContent)
            XCTAssertEqual(pushedBody.id, pushedContentId)
            XCTAssertEqual(pushedBody.parameter, route?.model as! Model)
        } else {
            XCTAssertNil(pushedContent)
        }
    }
    
    func test_routeIsNil_navigationLinkIsNotPresented() throws {
        try testNavigationLink(
            for: nil,
            isPresented: false
        )
    }
    
    func test_routeHasInvalidStyle_navigationLinkIsNotPresented() throws {
        try testNavigationLink(
            for: .init(model: 0, style: .sheet),
            isPresented: false
        )
    }
    
    func test_routeHasInvalidModel_navigationLinkIsNotPresented() throws {
        try testNavigationLink(
            for: .init(model: "invalid", style: .navigationLink),
            isPresented: false
        )
    }
    
    func test_routeIsValid_navigationLinkIsPresented() throws {
        try testNavigationLink(
            for: .init(model: 0, style: .navigationLink),
            isPresented: true
        )
    }
}
