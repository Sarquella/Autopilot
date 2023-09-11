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
    
    public static func buildPartialBlock<M0: DestinationModule>(
        first: M0
    ) -> some Destinable {
        first.destinations
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
    
    public static func buildPartialBlock<M0: DestinationModule, M1: DestinationModule>(
        accumulated: M0,
        next: M1
    ) -> some Destinable {
        buildPartialBlock(
            accumulated: accumulated.destinations,
            next: next.destinations
        )
    }
    
    public static func buildPartialBlock<D0: Destinable, M0: DestinationModule>(
        accumulated: D0,
        next: M0
    ) -> some Destinable {
        buildPartialBlock(
            accumulated: accumulated,
            next: next.destinations
        )
    }
}
