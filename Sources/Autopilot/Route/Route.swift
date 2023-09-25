//
//  Route.swift
//  
//
//  Created by Adrià Sarquella Farrés on 25/9/23.
//

struct Route {
    typealias Model = Any
    let model: Model
    let style: Style
}

extension Route {
    enum Style {
        case navigationLink
        case sheet
        case fullScreenCover
    }
}
