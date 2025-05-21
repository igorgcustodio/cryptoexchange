import Foundation

extension DateFormatter {
    /// This date formatter parses date in format `yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ`
    /// Example: `2017-12-18T00:00:00.0000000Z`
    public static var customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
