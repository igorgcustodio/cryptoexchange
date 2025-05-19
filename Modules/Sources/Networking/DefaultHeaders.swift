import Foundation

enum DefaultHeaders {
    static let headers: [String: String] = [
        "Content-Type": "application/json",
        "Authorization": "Basic \(Environment.apiKey)",
    ]
}
