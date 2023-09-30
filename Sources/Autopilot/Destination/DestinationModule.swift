//
//  DestinationModule.swift
//  
//
//  Created by Adrià Sarquella Farrés on 12/9/23.
//

public protocol DestinationModule {
    associatedtype Destinations: Autopilot.Destination
    typealias Destination = _Destination
    @DestinationBuilder var destinations: Self.Destinations { get }
}
