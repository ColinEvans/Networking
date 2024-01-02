//
//  URLRequestBuilding.swift
//
//
//  Created by Colin Evans on 2024-01-01.
//

import Foundation

/// Models a Builder pattern approach to creating a `URLRequest`
///
/// Implementations should add a blank `URLRequest` object which is used in assembly
public protocol URLRequestBuilding {
  /// Appends a HTTP header and associated value to the request
  ///
  /// - Parameters:
  ///   - headerType: A type-safe pre-defined header type to append to the request
  ///   - value: The associated value to the `HeaderType` of the request
  func withHeaderOptions(headerType: HeaderType, value: String)

  /// Assigns a HTTP request method to the request being built
  ///
  /// - Parameter method: a type-safe `HTTP` method to assign to the request
  func withRequestType(method: HTTPMethod)
  
  /// Appends a list of n query items to the request being built.
  ///  Convenience method to map a query parameter name and value pairing to a `URLQueryItem`
  ///
  /// - Parameter parameters: a variadic list of (name, value) tuples of query items appended to the request
  func addQueryItems(for parameters: (name: String, value: String?)...)
  
  /// Retrieve the `URLRequest` that has been composed by zero or more of the building methods
  ///
  /// - Returns: The `URLRequest` that has been built
  func retrieveRequest() -> URLRequest
}
