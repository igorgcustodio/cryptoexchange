import Foundation
import Models
import Scenes

final class MockMainServiceProtocol: MainServiceProtocol {
    let result: Result<[Exchange], Error>

    init(result: Result<[Exchange], Error>) {
        self.result = result
    }

    func fetchExchanges() async throws -> [Exchange] {
        try result.get()
    }
}
