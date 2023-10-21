//
//  PresentationPair.swift
//  
//
//  Created by Adrià Sarquella Farrés on 1/10/23.
//

import SwiftUI

struct PresentationPair<Presentable, P0, P1>: Presentation
where Presentable: Destination,
      P0: Presentation<Presentable>,
      P1: Presentation<Presentable> {
    let first: P0
    let second: P1
    
    func body(
        root: Root,
        route: Binding<Route?>,
        destination: Presentable
    ) -> some View {
        root
            .presentations(for: destination) {
                first
            }
            .presentations(for: destination) {
                second
            }
    }
}
