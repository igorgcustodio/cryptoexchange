import CoreUI
import Foundation
import Models

public enum MainTableViewDataSection: TableViewEnumType {
    case exchanges
}

public enum MainTableViewDataRow: TableViewEnumType {
    case exchange(Exchange)
}

public final class MainTableViewData: TableViewData<MainTableViewDataSection, MainTableViewDataRow> { }
