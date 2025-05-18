import CoreUI
import UIKit

extension UITableView {

    public static func buildTableView(
        isScrollEnabled: Bool = true,
        style: Style = .plain,
        allowsSelection: Bool? = nil
    ) -> UITableView {
        let tableView = UITableView(frame: .zero, style: style)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = isScrollEnabled
        if let allowsSelection  {
            tableView.allowsSelection = allowsSelection
        }

        return tableView
    }

    public func register<T: UITableViewCell>(_: T.Type) where T: ReusableIdentifier {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableIdentifier {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }


}
