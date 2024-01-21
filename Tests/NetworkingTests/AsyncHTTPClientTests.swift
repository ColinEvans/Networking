//
//  File.swift
//  
//
//  Created by Colin Evans on 2024-01-20.
//

import XCTest
import Mocker

@testable import Networking

final class AsyncHTTPClientTests: XCTestCase {
  var sut: AsyncHTTPClient!
  var transport: (any AsyncTransport)!
  var httpRequest = MockHTTPRequest()
  let url = URL(string: "www.someExample.com")!
  let encodedResult = try! JSONEncoder().encode("{ hello: world }")
  
  override func setUp() {
    super.setUp()
    transport = URLSession.shared
    sut = AsyncHTTPClient(transport: transport)
  }
  
  func test_response_withValidHTTPStatus_returnsResource() async {
    // Arrange
    let mock = Mock(url: URL(string: httpRequest.path)!, statusCode: 200, data: [.get : encodedResult])
    httpRequest.setMockRequest(for: mock.request)
    let expectedResult = "{ hello: world }"
    mock.register()
    
    // Act & Assert
    do {
      guard let resource = try await sut.response(for: httpRequest) as? String else {
        XCTFail()
        return
      }
      XCTAssertEqual(expectedResult, resource)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
  
  func test_response_withInvalidHTTPStatus_throwsInvalidResponse() async {
    // Arrange
    let mock = Mock(url: URL(string: httpRequest.path)!, statusCode: 400, data: [.get : encodedResult])
    httpRequest.setMockRequest(for: mock.request)
    mock.register()
    
    // Act & Assert
    do {
      let _ = try await sut.response(for: httpRequest)
      XCTFail()
    } catch let error as HTTPClientError {
      XCTAssertEqual(error, HTTPClientError.invalidResponse)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
}
