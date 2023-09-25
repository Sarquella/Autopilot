//
//  Environment+Router.swift
//  
//
//  Created by Adrià Sarquella Farrés on 25/9/23.
//

import SwiftUI

private struct RouterKey: EnvironmentKey {
  static let defaultValue = Router()
}

extension EnvironmentValues {
    var router: Router {
        get { self[RouterKey.self] }
        set { self[RouterKey.self] = newValue }
    }
}
