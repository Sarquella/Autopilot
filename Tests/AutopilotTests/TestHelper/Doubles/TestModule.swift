//
//  TestModule.swift
//  
//
//  Created by Adrià Sarquella Farrés on 12/9/23.
//

import Autopilot
import SwiftUI

struct TestModule<Model>: DestinationModule, Identifiable {
    let id: TestIdentifier<Self>
    
    init(id: TestIdentifier<Self> = .init()) {
        self.id = id
    }
    
    var destinations: some Destination {
        TestDestination(Model.self, id: .init(id.value))
    }
}


