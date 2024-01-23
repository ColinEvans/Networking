//
//  Resource.swift
//
//
//  Created by Colin Evans on 2023-11-17.
//

import Foundation

/// Groups  related endpoint `URL` with a parse function to map the `Data` into the concrete
/// type passed into the struct
public struct Resource<A: Decodable> {
  let parse: (Data) throws -> A
  
  public init(parse: @escaping (Data) throws -> A) {
    self.parse = parse
  }
}

public extension Resource {
  init() {
    let parse = {
      try JSONDecoder().decode(A.self, from: $0)
    }
    self.init(parse: parse)
  }
}
