import CoreUI
import UIKit

public final class MainView: UIView {

    public init() {
        super.init(frame: .zero)
        setupViewCode()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView: ViewCodeConfiguration {
    public func setupViewHierarchy() {

    }

    public func setupConstraints() {

    }

    public func configureViews() {

    }
}
