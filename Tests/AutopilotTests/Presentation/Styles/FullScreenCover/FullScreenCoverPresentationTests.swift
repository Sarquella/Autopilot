//
//  FullScreenCoverPresentationTests.swift
//  
//
//  Created by Adrià Sarquella Farrés on 4/10/23.
//

import XCTest
@testable import Autopilot
import SwiftUI
@testable import ViewInspector

class FullScreenCoverPresentationTests: XCTestCase {
    func testFullScreenCover(
        for route: Route?,
        isPresented: Bool
    ) throws {
        typealias Model = Int
        typealias FullScreenCover = TestView<Model>
        typealias Destination = _Destination<Model, FullScreenCover>
        typealias Root = TestView<Void>
        
        let fullScreenCoverId: FullScreenCover.ID = .init("fullScreenCoverId")
        let destination = Destination(Model.self) { parameter in
            FullScreenCover(
                id: fullScreenCoverId,
                parameter: parameter
            )
        }
        
        let router = Router()
        router.route = route
        
        let body = Root()
            .presentations(for: destination) {
                FullScreenCoverPresentation<Destination>()
            }
            .environmentObject(router)
        
        let fullscreenCover = try? body
            .inspect()
            .view(Root.self)
            .fullScreenCover()
        
        if isPresented {
            let fullScreenCoverBody = try XCTUnwrap(fullscreenCover)
                .find(FullScreenCover.self)
                .actualView()
            XCTAssertEqual(fullScreenCoverBody.id, fullScreenCoverId)
            XCTAssertEqual(fullScreenCoverBody.parameter, route?.model as! Model)
        } else {
            XCTAssertNil(fullscreenCover)
        }
    }
    
    func test_routeIsNil_fullScreenCoverIsNotPresented() throws {
        try testFullScreenCover(
            for: nil,
            isPresented: false
        )
    }
    
    func test_routeHasInvalidStyle_fullScreenCoverIsNotPresented() throws {
        try testFullScreenCover(
            for: .init(model: 0, style: .sheet),
            isPresented: false
        )
    }
    
    func test_routeHasInvalidModel_fullScreenCoverIsNotPresented() throws {
        try testFullScreenCover(
            for: .init(model: "invalid", style: .fullScreenCover),
            isPresented: false
        )
    }
    
    func test_routeIsValid_andIsSupportedOS_fullScreenCoverIsPresented() throws {
        if !isFullScreenCoverSupported {
            throw XCTSkip("fullScreenCover not supported for current OS")
        }
        
        try testFullScreenCover(
            for: .init(model: 0, style: .fullScreenCover),
            isPresented: true
        )
    }
    
    func test_routeIsValid_andIsUnsupportedOS_fullScreenCoverIsNotPresented() throws {
        if isFullScreenCoverSupported {
            throw XCTSkip("fullScreenCover supported for current OS")
        }
        
        try testFullScreenCover(
            for: .init(model: 0, style: .fullScreenCover),
            isPresented: false
        )
    }
}

private extension FullScreenCoverPresentationTests {
    var isFullScreenCoverSupported: Bool {
        #if os(iOS) || os(tvOS) || os(watchOS)
        if #available(iOS 14.0, tvOS 14.0, watchOS 7.0, *) {
            return true
        }
        #endif
        return false
    }
}

@available(macOS, unavailable)
@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension FullScreenCoverPresentationModifier: PopupPresenter {
    public typealias Popup = FullScreenCover
    public var popupBuilder: () -> FullScreenCover { fullScreenCover }
    public var onDismiss: (() -> Void)? { nil }
}

/*
 OS agnostic version of https://github.com/nalexn/ViewInspector/blob/0.9.9/Sources/ViewInspector/SwiftUI/Sheet.swift#L55
 */
extension InspectableView {
    func fullScreenCover() throws -> InspectableView<ViewType.FullScreenCover> {
        return try contentForModifierLookup.sheet(
            parent: self,
            index: nil,
            name: "FullScreenCover"
        )
    }
}
