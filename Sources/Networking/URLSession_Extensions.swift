import Foundation

public extension URLSession {
  /// Performs a URL `GET` request for a given `Resource` and attempts to parse the results
  ///
  /// - Parmaters:
  ///   - resource: A `Resource` with a concrete `Codable` type
  /// - Returns: `A` where `A` is a concrete `Codable` type provided by the `Resource`
  ///   or throws an `Error` if the data cannot be parsed
  func load<A>(resource r: Resource<A>) async throws -> A {
    let (data, response) = try await URLSession.shared.data(from: r.url)
    if let httpResponse = response as? HTTPURLResponse,
       (200...299).contains(httpResponse.statusCode) {
      return try r.parse(data)
    }
    throw URLError(.badServerResponse)
  }
}
