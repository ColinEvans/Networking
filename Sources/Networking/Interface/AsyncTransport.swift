//
//  AsyncTransport.swift
//
//
//  Created by Colin Evans on 2024-01-20.
//

import Foundation

/// Carries `Data` from the network via async/await
public protocol AsyncTransport {
  /// Invokes the provided `URLRequest` and converts the result to an `ClientResponse`
  ///
  /// - Parameter request: Any `URLRequest`
  /// - Returns: `Data` and a `URLResponse`
  func response(for request: URLRequest) async throws -> ClientDataResponse
}
