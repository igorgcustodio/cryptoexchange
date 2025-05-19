import UIKit

extension UITextField {
    public static func buildTextField(
        placeholder: String? = nil,
        keyboardType: UIKeyboardType = .default
    ) -> UITextField {
        let textField = CustomTextField(
            keyboardType: keyboardType,
            placeholder: placeholder
        )

        textField.returnKeyType = .done
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no

        return textField
    }
}
