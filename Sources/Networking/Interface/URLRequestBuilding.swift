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
  /// - Parameter headers: A dictionary of  HTTP name and value pairings
  func withHeaderOptions(headers: [String : String])

  /// Assigns a HTTP request method to the request being built
  ///
  /// - Parameter method: a type-safe `HTTP` method to assign to the request
  func withRequestType(method: HTTPMethod)
  
  /// Appends a list of n query items to the request being built.
  ///  Convenience method to map a query parameter name and value pairing to a `URLQueryItem`
  ///
  /// - Parameter parameters: a dictionary of query items appended to the request
  func addQueryItems(for parameters: [String : String])
  
  /// Retrieve the `URLRequest` that has been composed by zero or more of the building methods
  ///  and resets the interal request object
  ///
  /// - Returns: The `URLRequest` that has been built
  func retrieveRequest() -> URLRequest
}
