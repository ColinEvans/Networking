//
//  URLRequestBuilder.swift
//
//
//  Created by Colin Evans on 2024-01-01.
//

import Foundation

public enum HeaderType: String {
  case auth = "Authorization" //authorization
}

public protocol URLRequestBuilding {
  func withHeaderOptions(headerType: HeaderType, value: String)
  func withRequestType(method: HTTPMethod)
  func withQueryItem(name: String, value: String?)
}

public class URLRequestBuilder {
  private var request: URLRequest
  private let url: URL
  
  init(_ url: URL) {
    self.request = URLRequest(url: url)
    self.url = url
  }

  func retrieveRequest() -> URLRequest {
    let result = request
    reset()
    return result
  }
  
  func reset() {
    request = URLRequest(url: url)
  }
}

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
}
