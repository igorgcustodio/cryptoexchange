import UIKit

public final class CustomLabel: UILabel {
    private let color: UIColor

    public init(
        color: UIColor,
        numberOfLines: Int = 1
    ) {
        self.color = color
        super.init(frame: .zero)
        setupView()
        self.numberOfLines = numberOfLines
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomLabel {
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = color
    }
}
