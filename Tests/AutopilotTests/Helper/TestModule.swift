//
//  TestModule.swift
//  
//
//  Created by Adrià Sarquella Farrés on 12/9/23.
//

import Autopilot
import SwiftUI

struct TestModule<Model>: DestinationModule {
    let id: String
    
    init(id: String = "\(Model.self)") {
        self.id = id
    }
    
    var destinations: some Destination {
        TestDestination(Model.self, id: id)
    }
}


