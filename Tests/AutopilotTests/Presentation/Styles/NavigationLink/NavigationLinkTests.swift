//
//  NavigationLinkTests.swift
//
//
//  Created by Adrià Sarquella Farrés on 13/11/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
import ViewInspector

class NavigationLinkTests: XCTestCase {
    func test_whenLabelIsProvided_bodyIsButtonWithLabel() throws {
        typealias Label = TestView<Void>
        let navigationLink = NavigationLink(value: "") {
            Label()
        }.environmentObject(Router())
        
        let button = try navigationLink
            .inspect()
            .button()
        _ = try button
            .labelView()
            .view(Label.self)
    }
    
    func test_whenTitleIsProvided_bodyIsButtonWithText() throws {
        let title: LocalizedStringKey = "title"
        let navigationLink = NavigationLink(
            title,
            value: ""
        ).environmentObject(Router())
        
        let button = try navigationLink
            .inspect()
            .button()
        let label = try button
            .labelView()
            .text()
        let text = try label.string()
        XCTAssertEqual(
            LocalizedStringKey(text),
            title
        )
    }
    
    func test_beforeButtonTap_routerIsNotUpdated() {
        let router = Router()
        let _ = NavigationLink(
            "",
            value: "value"
        ).environmentObject(router)
        
        XCTAssertNil(router.route)
    }
    
    func test_afterButtonTap_routerIsUpdated() throws {
        let router = Router()
        let value = "value"
        let navigationLink = NavigationLink(
            "",
            value: value
        ).environmentObject(router)
        
        try navigationLink
            .inspect()
            .button()
            .tap()
        
        XCTAssertEqual(router.route?.model as! String, value)
        XCTAssertEqual(router.route?.style, .navigationLink)
    }
}
