import CoreUI
import UIKit

public final class ToastView: UIView {
    public struct Content {
        let text: String

        public init(text: String) {
            self.text = text
        }
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

    public init(content: Content) {
        self.content = content
        super.init(frame: .zero)
        setupViewCode()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View code

extension ToastView: ViewCodeConfiguration {
    public func setupViewHierarchy() {
        addSubview(container)
        container.addSubview(descriptionLabel)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
        ])
    }

    public func configureViews() {
        descriptionLabel.text = content.text
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

public extension ToastView {
    static func show(
        text: String,
        in parentView: UIView,
        automaticDismiss: Bool = true
    ) {
        let toast = ToastView(content: .init(text: text))
        toast.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(toast)

        NSLayoutConstraint.activate([
            toast.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            toast.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            toast.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            toast.heightAnchor.constraint(equalToConstant: 80)
        ])

        toast.alpha = 0

        parentView.addSubview(toast)

        UIView.animate(
            withDuration: 0.3,
            animations: { toast.alpha = 1 }
        )

        toast.setupInteraction()

        if automaticDismiss {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                toast.dismiss()
            }
        }
    }

    private func setupInteraction() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleDismiss(_:)))
        swipeUp.direction = .up
        addGestureRecognizer(swipeUp)

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismiss(_:)))
        addGestureRecognizer(tap)
    }

    @objc private func handleDismiss(_ gesture: UIGestureRecognizer) {
        dismiss()
    }

    private func dismiss() {
        UIView.animate(
            withDuration: 0.3,
            animations: { self.alpha = 0 },
            completion: { _ in self.removeFromSuperview() }
        )
    }
}
