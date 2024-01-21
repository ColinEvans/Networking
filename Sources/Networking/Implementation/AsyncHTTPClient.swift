//
//  AsyncHTTPClient.swift
//
//
//  Created by Colin Evans on 2024-01-20.
//

import Foundation

/// An HTTP client which using structured concurrency
public struct AsyncHTTPClient {
  /// The `AsyncTransport` which will be used to invoke each `HTTPRequest`
  public let transport: AsyncTransport
    
  /// Creates an `AsyncHTTPClient` with the given parameters
  ///
  /// - Parameter transport: The `AsyncTransport` which will be used to invoke each `HTTPRequest`
  public init(
    transport: AsyncTransport = URLSession.shared
  ) {
    self.transport = transport
  }

  /// Issues each `HTTPRequest` via the `AsyncTransport` and validates the result
  ///
  /// - Parameters:
  ///   - request: Any `HTTPRequest`
  ///   - desiredHTTPStatusCodes: A set of accepted HTTP codes, defaults to the entire 200 range
  /// - Returns: A decoded `Request.HTTPResponse` if returned from the service
  public func response<Request: HTTPRequest>(
      for request: Request,
      httpStatusCodeWithin desiredHTTPStatusCodes: Set<Int> = Set(200...299)
  ) async throws -> Request.HTTPResponse {
    let result = try await transport.response(for: request.build())
      guard result.response.wasSuccessful(within: desiredHTTPStatusCodes) else {
        throw HTTPClientError.invalidResponse
      }
    return try request.resource.parse(result.data)
  }
}

private extension URLResponse {
  /// A convenience function to determine whether the HTTP `statusCode`
  /// for a given `URLResponse` fell within a given range of HTTP status codes
  ///
  /// - Parameter acceptableStatusCodes: A set of accepted HTTP codes
  /// - Returns: Whether or not `self` is a valid `HTTPURLResponse` and
  ///            the `statusCode` falls within `statusRange`
  func wasSuccessful(within acceptableStatusCodes: Set<Int>) -> Bool {
    guard let httpResponse = self as? HTTPURLResponse else {
      return false
    }
    return acceptableStatusCodes.contains(httpResponse.statusCode)
  }
}
