import UIKit

extension UILabel {
    public static func buildLabel(
        color: UIColor,
        numberOfLines: Int = 1,
        isHidden: Bool = false,
        text: String? = nil
    ) -> UILabel {
        let label = CustomLabel(color: color, numberOfLines: numberOfLines)
        label.isHidden = isHidden

        if let text {
            label.text = text
        }

        return label
    }
}
