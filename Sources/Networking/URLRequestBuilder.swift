//
//  URLRequestBuilder.swift
//
//
//  Created by Colin Evans on 2024-01-01.
//

import Foundation

/// Concrete `Builder` implementation of `URLRequestBuilding`
public class URLRequestBuilder {
  private var request: URLRequest
  private let url: URL
  
  public init(_ url: URL) {
    self.request = URLRequest(url: url)
    self.url = url
  }

  func reset() {
    request = URLRequest(url: url)
  }
}

// MARK: - Extensions<URLRequestBuilding>
extension URLRequestBuilder: URLRequestBuilding {
  public func withHeaderOptions(headerType: HeaderType, value: String) {
    request.setValue(value, forHTTPHeaderField: headerType.rawValue)
  }
  
  public func withRequestType(method: HTTPMethod) {
    request.httpMethod = method.rawValue
  }
  
  public func withQueryItem(name: String, value: String?) {
    var url = request.url
    let queryItem = URLQueryItem(name: name, value: value)
    if #available(iOS 16.0, *) {
      url?.append(queryItems: [queryItem])
    }

    request.url = url
  }
  
  public func retrieveRequest() -> URLRequest {
    let result = request
    reset()
    return result
  }
}
