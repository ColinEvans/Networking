//
//  URLRequestBuilderTests.swift
//  
//
//  Created by Colin Evans on 2024-01-01.
//

import XCTest
@testable import Networking

final class URLRequestBuilderTests: XCTestCase {
  
  var sut: URLRequestBuilder!
  let url = URL(string: "www.someExample.com")!
  
  override func setUp() {
    super.setUp()
    sut = URLRequestBuilder(url)
  }
  
  func test_URLRequestBuilder_withPOSTRequest_matchesRequest() {
    // Arrange
    var expectedRequest = URLRequest(url: url)
    expectedRequest.httpMethod = "POST"
    
    // Act
    sut.withRequestType(method: .POST)
    
    // Assert
    XCTAssertEqual(sut.retrieveRequest().httpMethod, expectedRequest.httpMethod)
  }
  
  func test_URLRequestBuilder_withSingleQueryItem_matchesURL() {
    // Arrange
    let expectedURL = URL(string: url.absoluteString + "?example=result")
    
    // Act
    sut.addQueryItems(for: ["example" : "result"])
    
    // Assert
    XCTAssertEqual(
      sut.retrieveRequest().url?.absoluteString,
      expectedURL?.absoluteString
    )
  }
  
  func test_URLRequestBuild_withMultipleQueryItems_matchesURL() {
    // Arrange
    let expectedURL = URL(string: url.absoluteString + "?example=result&other=newResult")
  
    // Act
    sut.addQueryItems(for: ["example" : "result", "other" : "newResult"])
    
    // Assert
    XCTAssertEqual(
      sut.retrieveRequest().url?.absoluteString,
      expectedURL?.absoluteString
    )
  }

  func test_URLRequest_withHeaderOption_matchesExpected() {
    // Arrange
    let expectedHeader = "Authorization"
    let expectedResult = "example"
    
    // Act
    sut.withHeaderOptions(headerType: .auth, value: "example")
    
    // Assert
    let fields = sut.retrieveRequest().allHTTPHeaderFields
    XCTAssertNotNil(fields)
    XCTAssertEqual(expectedResult, fields![expectedHeader])
  }
}
