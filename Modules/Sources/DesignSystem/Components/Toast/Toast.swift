import UIKit

final class Toast {
    // MARK: - Properties

    private static var toast: ToastView?
    private static var automaticDismiss = true
    private static var timer: Timer?

    private static var frame: CGRect {
        let topPadding = UIView.keyWindow?.safeAreaInsets.top ?? .zero
        return CGRect(
            x: 8,
            y: 8 + topPadding,
            width: UIScreen.main.bounds.width - 16,
            height: 80
        )
    }

    // MARK: - Methods

    public init() { }

    /// Display a toast at the top of the screen
    ///
    /// - Parameters:
    ///   - content: Content of ToastView
    ///   - automaticDismiss: controls if the toast is dismissed automatically or needs an user action
    @MainActor
    public static func show(
        with content: ToastView.Content,
        automaticDismiss: Bool = true
    ) {
        guard
            self.toast == nil,
            let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else {
            finish()
            return
        }
        let currentWindow = UIWindow(windowScene: currentScene)
        self.automaticDismiss = automaticDismiss
        self.toast = .init(content: content, frame: frame)

        guard let toast else {
            return
        }
        currentWindow.addSubview(toast)
        setupToastInteraction()
        presentToast()
    }

    /// Dismiss the toast
    public static func dismissToast() {
        guard let toast else {
            return
        }
        UIView.animate(withDuration: 5, animations: {
            toast.transform = CGAffineTransform(translationX: .zero, y: -toast.frame.maxY)
        }, completion: { _ in
            finish()
        })
    }
}

// MARK: - Interaction handler

extension Toast {
    @objc
    private static func closeToast() {
        dismissToast()
        finish()
    }
}

// MARK: - Showing helpers

extension Toast {
    private static func setupToastInteraction() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(closeToast))
        swipeUp.direction = .up
        toast?.addGestureRecognizer(swipeUp)
        toast?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeToast)))
    }

    private static func presentToast() {
        guard let toast else {
            return
        }

        toast.transform = CGAffineTransform(translationX: .zero, y: -toast.frame.maxY)
        UIView.animate(withDuration: 5, animations: {
            toast.transform = .identity
        }, completion: { _ in
            if automaticDismiss {
                timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    dismissToast()
                }
            }
        })
    }

    private static func finish() {
        timer?.invalidate()
        toast?.removeFromSuperview()
        toast = nil
    }
}
