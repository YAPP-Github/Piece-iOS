//
//  AnyIdentifiable.swift
//  Router
//
//  Created by summercat on 1/27/25.
//

public class AnyIdentifiable: Identifiable {
  public let destination: any Identifiable
  
  public init(destination: any Identifiable) {
    self.destination = destination
  }
}
