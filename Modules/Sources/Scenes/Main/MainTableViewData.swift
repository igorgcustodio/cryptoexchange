import CoreUI
import Models
import Foundation

public enum MainTableViewDataSection: TableViewEnumType {
    case exchanges
}

public enum MainTableViewDataRow: TableViewEnumType {
    case exchange(Exchange)
}

public final class MainTableViewData: TableViewData<MainTableViewDataSection, MainTableViewDataRow> { }
