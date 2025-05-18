import UIKit

extension UIView {

    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }

    public func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.2,
        offset: CGSize = CGSize(width: 1.0, height: 3.0),
        radius: CGFloat = 3.0
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }

    public static var emptyView: UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    public func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }

    public func cornerRadius(with radius: CGFloat = 4) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
