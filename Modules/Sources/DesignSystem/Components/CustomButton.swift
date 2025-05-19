import UIKit

open class CustomButton: UIButton {
    // MARK: - Init

    public init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupView()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override methods

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !state.contains(.disabled) {
            performScaleAnimation()
        }
        super.touchesBegan(touches, with: event)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !state.contains(.disabled) {
            UIView.animate(withDuration: 0.3) {
                self.layer.opacity = 1
            }
        }
        super.touchesEnded(touches, with: event)
    }

    func performScaleAnimation() {
        layer.removeAllAnimations()

        let scaleDownAnimation = CABasicAnimation(keyPath: Config.Animation.type)
        scaleDownAnimation.fromValue = Config.Animation.maxScale
        scaleDownAnimation.toValue = Config.Animation.minScale
        scaleDownAnimation.duration = Config.Animation.scaleDownDuration
        scaleDownAnimation.isRemovedOnCompletion = true
        scaleDownAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let scaleUpAnimation = CABasicAnimation(keyPath: Config.Animation.type)
        scaleUpAnimation.fromValue = Config.Animation.minScale
        scaleUpAnimation.toValue = Config.Animation.maxScale
        scaleUpAnimation.beginTime = scaleDownAnimation.duration
        scaleUpAnimation.duration = Config.Animation.scaleUpDuration
        scaleUpAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleDownAnimation, scaleUpAnimation]
        animationGroup.duration = scaleDownAnimation.duration + scaleUpAnimation.duration

        layer.add(animationGroup, forKey: Config.Animation.key)

        layer.opacity = 0.8
    }
}

// MARK: - Setup View

extension CustomButton {
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
    }
}

// MARK: - Constants and ViewData

extension CustomButton {
    // MARK: - Animation Config

    enum Config {
        enum Animation {
            static let type = "transform.scale"
            static let key = "scaleAnimation"
            static let minScale = 0.99
            static let maxScale = 1.0
            static let scaleDownDuration: CFTimeInterval = 0.1
            static let scaleUpDuration: CFTimeInterval = 0.17
        }
    }
}
