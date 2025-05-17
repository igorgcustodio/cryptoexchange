import Foundation

public protocol UIHelper: AnyObject {
    func setupUI()
    func setupViews()
    func setupLabels()
    func setupButtons()
    func setupImages()
    func setupTableViews()
    func setupCollectionViews()
    func setupTextFields()
    func setupTextViews()
    func setupNavigationBar()
}

extension UIHelper {
    public func setupUI() {
        setupViews()
        setupLabels()
        setupButtons()
        setupImages()
        setupTableViews()
        setupCollectionViews()
        setupTextFields()
        setupTextViews()
        setupNavigationBar()
    }

    public func setupViews() {}
    public func setupLabels() {}
    public func setupButtons() {}
    public func setupImages() {}
    public func setupTableViews() {}
    public func setupCollectionViews() {}
    public func setupTextFields() {}
    public func setupTextViews() {}
    public func setupNavigationBar() {}
}
