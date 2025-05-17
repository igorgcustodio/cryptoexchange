import Foundation

/// TableViewData struct to help handling table view data
///
/// This class aims to help us while creating table views structures. As a common process, we create a TableViewData struct/class to
/// handle our sections and rows, so, this class help us with that.
///
/// **Generic Params**
///
///     - U: enum with sections types (type: TableViewEnumType)
///     - W: enum with rows types (type: TableViewEnumType)
///
/// ```
open class TableViewData<W: TableViewEnumType, U: TableViewEnumType> {
    public typealias DataSection = TableViewDataSection<W, U>

    public init() {}

    public private(set) var sections: [DataSection] = []

    /// Count of all sections
    public var sectionCount: Int {
        sections.count
    }

    // Count of all visible sections
    public var visibleSectionCount: Int {
        visibleSections.count
    }

    /// Visible sections
    public var visibleSections: [DataSection] {
        sections.filter(\.visible)
    }

    public func sectionIndex(for sectionType: W) -> Int {
        for (index, section) in visibleSections.enumerated() where section.type == sectionType {
            return index
        }
        return -1
    }

    public func sectionType(at section: Int) -> W {
        visibleSections[section].type
    }

    public func rowType(in section: Int, in row: Int) -> U {
        visibleSections[section].rows[row]
    }

    public func add(sections: DataSection...) {
        self.sections.append(contentsOf: sections)
    }

    public func add(sections: [DataSection]) {
        self.sections.append(contentsOf: sections)
    }

    public func insert(section: DataSection, at index: Int) {
        sections.insert(section, at: index)
    }

    public func remove(sectionAt index: Int) {
        sections.remove(at: index)
    }

    public func remove(in section: Int, in row: Int) {
        sections[section].rows.remove(at: row)
    }

    public func clearData() {
        sections.removeAll()
    }
}

public protocol TableViewEnumType: EquatableAssociateValue {}

/// Struct to handle data in each section of table view
/// - Params:
///     - S: Sections enum
///     - R: Rows enum
public class TableViewDataSection<S: TableViewEnumType, R: TableViewEnumType> {
    public var rows: [R]
    public let type: S
    public var visible: Bool

    public init(rows: [R], type: S, visible: Bool = false) {
        self.rows = rows
        self.type = type
        self.visible = visible
    }
}
