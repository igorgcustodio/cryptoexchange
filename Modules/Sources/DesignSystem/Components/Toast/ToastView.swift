import CoreUI
import UIKit

final class ToastView: UIView {

    struct Content {
        let text: String
    }

    // MARK: - Views

    private lazy var descriptionLabel: UILabel = .buildLabel(
        color: .white,
        numberOfLines: .zero,
        text: content.text
    )
    private lazy var container: UIView = buildContainer()

    // MARK: - Properties

    private var content: Content

    // MARK: - Lifecycle

    init(content: Content, frame: CGRect) {
        self.content = content
        super.init(frame: frame)
        setupViewCode()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View code

extension ToastView: ViewCodeConfiguration {
    func setupViewHierarchy() {
        addSubview(container)
        container.addSubview(descriptionLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - View builders

extension ToastView {
    private func buildContainer() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }
}

