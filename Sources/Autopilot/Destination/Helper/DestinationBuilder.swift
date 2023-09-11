//
//  DestinationBuilder.swift
//  
//
//  Created by Adrià Sarquella Farrés on 12/9/23.
//

@resultBuilder
public struct DestinationBuilder {
    public static func buildPartialBlock<D0: Destinable>(
        first: D0
    ) -> some Destinable {
        first
    }
    
    public static func buildPartialBlock<D0: Destinable, D1: Destinable>(
        accumulated: D0,
        next: D1
    ) -> some Destinable {
        DestinationPair(
            first: accumulated,
            second: next
        )
    }
}
