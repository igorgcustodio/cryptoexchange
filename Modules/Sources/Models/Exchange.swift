import Foundation

public struct Exchange: Decodable {
    public let exchangeId: String
    public let website: String
    public let name: String
    public let dataQuoteStart: String
    public let dataQuoteEnd: String
    public let dataOrderbookStart: String
    public let dataOrderbookEnd: String
    public let dataTradeStart: String
    public let dataTradeEnd: String
    public let dataSymbolsCount: Int
    public let volume1hrsUsd: Double
    public let volume1dayUsd: Double
    public let volume1mthUsd: Double
    public let rank: Int

    public enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case website
        case name
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataOrderbookStart = "data_orderbook_start"
        case dataOrderbookEnd = "data_orderbook_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case dataSymbolsCount = "data_symbols_count"
        case volume1hrsUsd = "volume_1hrs_usd"
        case volume1dayUsd = "volume_1day_usd"
        case volume1mthUsd = "volume_1mth_usd"
        case rank
    }
}
