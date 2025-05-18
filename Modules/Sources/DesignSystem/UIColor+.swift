import UIKit

extension UIColor {
    public convenience init(hex: String) {
        let cleanHex = hex.replacingOccurrences(of: "#", with: "")

        let scanner = Scanner(string: cleanHex)
        scanner.currentIndex = scanner.string.startIndex

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }


    public var isDarkColor: Bool {
        luminosity < 0.50
    }

    public var luminosity: CGFloat {
        var red, green, blue, alpha: CGFloat
        (red, green, blue, alpha) = (0, 0, 0, 0)
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let lum = 0.2126 * red + 0.7152 * green + 0.0722 * blue
        return lum
    }

    public var contrastColor: UIColor {
        isDarkColor ? .white : .black
    }
}
