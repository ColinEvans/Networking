//
//  ClientDataResponse.swift
//
//
//  Created by Colin Evans on 2024-01-20.
//

import Foundation
import Combine

/// Represents the result of a `URLRequest`
public typealias ClientDataResponse = (data: Data, response: URLResponse)

/// A Combine publisher stream of API results
public typealias ClientResponsePublisher = AnyPublisher<ClientDataResponse, URLError>
