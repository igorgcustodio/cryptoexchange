import UIKit

extension CGFloat {
    static var topSafeArea: Self {
        UIView.keyWindow?.safeAreaInsets.top ?? .zero
    }

    static var bottomSafeArea: Self {
        UIView.keyWindow?.safeAreaInsets.bottom ?? .zero
    }
}
