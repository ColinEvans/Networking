//
//  Resource.swift
//
//
//  Created by Colin Evans on 2023-11-17.
//

import Foundation

/// Groups  related endpoint `URL` with a parse function to map the `Data` into the concrete
/// type passed into the struct
public struct Resource<A> {
  let url: URL
  let parse: (Data) throws -> A
}
