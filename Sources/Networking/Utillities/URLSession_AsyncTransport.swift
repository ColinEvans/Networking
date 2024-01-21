//
//  URLSession_AsyncTransport.swift
//  
//
//  Created by Colin Evans on 2024-01-20.
//

import Foundation

extension URLSession: AsyncTransport {
  /// Extends `URLSession` to conform to `AsyncTransport`
  ///
  /// - Parameter request: Any `URLRequest`
  /// - Returns: `Data` and a `URLResponse`
  public func response(for request: URLRequest) async throws -> ClientDataResponse {
    try await self.data(for: request)
  }
}
