//
//  File.swift
//  
//
//  Created by Colin Evans on 2024-01-10.
//

import Foundation

public protocol HTTPRequest {
  associatedtype HTTPResponse: Decodable
  
  /// The endpoint string that will be appended to the client's base URL
  var path: String { get }

  /// The HTTP verb used for this request, defaults to `GET`
  var method: HTTPMethod { get }
  
  /// Possible HTTP headers, defaults to an empty list
  var headers: [String: String] { get }
  
  /// Possible HTTP parameters for the query string, defaults to an empty list
  var parameters: [String: String] { get }
  
  var resource: Resource<HTTPResponse> { get }
  
  func build() -> URLRequest
}
