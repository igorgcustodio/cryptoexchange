import Foundation
import Models

extension Exchange {
    static func mock(id: String = "mock") -> Exchange {
        Exchange(
            exchangeId: id,
            website: "https://\(id).com",
            name: id.capitalized,
            dataQuoteStart: nil,
            dataQuoteEnd: nil,
            dataOrderbookStart: nil,
            dataOrderbookEnd: nil,
            dataTradeStart: nil,
            dataTradeEnd: nil,
            dataSymbolsCount: nil,
            volume1hrsUsd: nil,
            volume1dayUsd: nil,
            volume1mthUsd: nil,
            rank: nil
        )
    }
}
