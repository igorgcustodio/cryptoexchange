import UIKit

final class MainView: UIView {

    init() {
        super.init(frame: .zero)
        setupViewCode()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView: ViewCodeConfiguration {
    func setupViewHierarchy() {

    }

    func setupConstraints() {

    }

    func configureViews() {

    }
}
