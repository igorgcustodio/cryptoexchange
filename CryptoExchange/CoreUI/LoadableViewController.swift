import UIKit

open class LoadableViewController<ContentView: UIView>: UIViewController {

    public var contentView = ContentView()

    override open func loadView() {
        view = contentView
    }

    public init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
    }

    public init(withNib: Bool) {
        let nibName: String? = withNib ? String(describing: type(of: self)) : nil
        let bundle: Bundle? = withNib ? Bundle(for: type(of: self)) : nil
        super.init(nibName: nibName, bundle: bundle)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
