//
//  DestinationModule.swift
//  
//
//  Created by Adrià Sarquella Farrés on 12/9/23.
//

public protocol DestinationModule {
    typealias Destinations = Destinable
    associatedtype Graph: Destinations
    typealias Destination = _Destination
    @DestinationBuilder var destinations: Self.Graph { get }
}
