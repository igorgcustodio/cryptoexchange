import UIKit

extension UIImageView {
    public static func buildImageView(image: UIImage? = nil, contentMode: ContentMode = .scaleAspectFit) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = contentMode
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
