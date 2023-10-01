//
//  TestModule.swift
//  
//
//  Created by Adrià Sarquella Farrés on 12/9/23.
//

import Autopilot
import SwiftUI

struct TestModule<Model>: DestinationModule {
    let id: TestIdentifier<Self>
    
    init(id: TestIdentifier<Self> = .init("\(Model.self)")) {
        self.id = id
    }
    
    var destinations: some Destination {
        TestDestination(Model.self, id: .init(id.value))
    }
}


