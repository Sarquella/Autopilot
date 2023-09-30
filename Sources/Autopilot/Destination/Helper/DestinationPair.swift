//
//  DestinationPair.swift
//  
//
//  Created by Adrià Sarquella Farrés on 11/9/23.
//

import SwiftUI

struct DestinationPair<D0: Destination, D1: Destination> {
    let first: D0
    let second: D1
}

extension DestinationPair: Destination {
    func transform(model: Any) -> Model? {
        if let firstModel = model as? D0.Model {
            return .init(first: firstModel, second: nil)
        } else if let secondModel = model as? D1.Model {
            return .init(first: nil, second: secondModel)
        }
        return nil
    }
    
    func body(for model: Model) -> some View {
        if let firstModel = model.first {
            first.body(for: firstModel)
        } else if let secondModel = model.second {
            second.body(for: secondModel)
        } else {
            InvalidDestination()
        }
    }
}

extension DestinationPair {
    struct Model {
        let first: D0.Model?
        let second: D1.Model?
    }
}
