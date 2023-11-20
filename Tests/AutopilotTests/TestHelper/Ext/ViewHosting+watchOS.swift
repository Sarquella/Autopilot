//
//  ViewHosting+watchOS.swift
//
//
//  Created by Adrià Sarquella Farrés on 20/11/23.
//

import XCTest
import SwiftUI
import ViewInspector

extension ViewHosting {
    static func host<Content: View>(view: Content) throws {
        #if os(watchOS)
        throw XCTSkip("View hosting not supported for watchOS")
        #else
        ViewHosting.host(view: view, size: nil)
        #endif
    }
}
