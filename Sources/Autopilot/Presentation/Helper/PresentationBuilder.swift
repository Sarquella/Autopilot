//
//  PresentationBuilder.swift
//  
//
//  Created by Adrià Sarquella Farrés on 1/10/23.
//

@resultBuilder
struct PresentationBuilder {
    static func buildPartialBlock<Presentable: Destination>(
        first: some Presentation<Presentable>
    ) -> some Presentation<Presentable> {
        first
    }
    
    static func buildPartialBlock<Presentable: Destination>(
        accumulated: some Presentation<Presentable>,
        next: some Presentation<Presentable>
    ) -> some Presentation<Presentable> {
        PresentationPair(
            first: accumulated,
            second: next
        )
    }
}
