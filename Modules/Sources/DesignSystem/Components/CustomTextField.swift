import UIKit

final class CustomTextField: UITextField {
    let insets: UIEdgeInsets

    init(
        insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
        keyboardType: UIKeyboardType,
        placeholder: String? = nil
    ) {
        self.insets = insets
        super.init(frame: .zero)
        self.placeholder = placeholder
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        clearButtonMode = .whileEditing
        addBorder()
    }

    private func addBorder() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        addSubview(view)

        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
