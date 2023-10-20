//
//  DestinationBuilder.swift
//  
//
//  Created by Adrià Sarquella Farrés on 12/9/23.
//

@resultBuilder
public struct DestinationBuilder {
    public static func buildPartialBlock<D0: Destination>(
        first: D0
    ) -> some Destination {
        first
    }
    
    public static func buildPartialBlock<M0: DestinationModule>(
        first: M0
    ) -> some Destination {
        first.destinations
    }
    
    public static func buildPartialBlock<D0: Destination, D1: Destination>(
        accumulated: D0,
        next: D1
    ) -> some Destination {
        DestinationPair(
            first: accumulated,
            second: next
        )
    }
    
    public static func buildPartialBlock<M0: DestinationModule, M1: DestinationModule>(
        accumulated: M0,
        next: M1
    ) -> some Destination {
        buildPartialBlock(
            accumulated: accumulated.destinations,
            next: next.destinations
        )
    }
    
    public static func buildPartialBlock<D0: Destination, M0: DestinationModule>(
        accumulated: D0,
        next: M0
    ) -> some Destination {
        buildPartialBlock(
            accumulated: accumulated,
            next: next.destinations
        )
    }
}
