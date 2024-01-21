//
//  File 2.swift
//  
//
//  Created by Colin Evans on 2024-01-20.
//

import Foundation

@testable import Networking

struct MockHTTPRequest: HTTPRequest {
  typealias HTTPResponse = String
  
  let path: String = "www.someExample.com"
  let method: Networking.HTTPMethod = .GET
  var headers = [String : String]()
  var parameters = [String : String]()
  let resource = Resource<String>()
  var mockRequest: URLRequest?
  
  func build() -> URLRequest {
    mockRequest!
  }
  
  mutating func setMockRequest(for request: URLRequest) {
    self.mockRequest = request
  }
}
