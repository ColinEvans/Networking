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
  public func withHeaderOptions(headers: [String : String]) {
    headers.keys.compactMap { key -> String? in
      guard HeaderType(rawValue: key) != nil else { return nil }
      return key
    }.forEach {
      guard let value = headers[$0] else {
        return
      }
      request.setValue(value, forHTTPHeaderField: $0)
    }
  }
  
  public func withRequestType(method: HTTPMethod) {
    request.httpMethod = method.rawValue
  }
  
  public func addQueryItems(for parameters: [String : String]) {
    var url = request.url
    if #available(iOS 16.0, *) {
      url?.append(queryItems: parameters.map { URLQueryItem(name: $0, value: $1) })
    }

    request.url = url
  }
  
  public func retrieveRequest() -> URLRequest {
    let result = request
    reset()
    return result
  }
}
