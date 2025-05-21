import CoreUI
import UIKit

public final class ExchangeDetailsViewController: LoadableViewController<ExchangeDetailsView> {
    // MARK: - Properties

    private let viewModel: ExchangeDetailsViewModelProtocol

    // MARK: - Lifecycle

    public init(viewModel: ExchangeDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    // MARK: - Methods

    private func bind() {
        let data = viewModel.exchange
        contentView.nameLabel.text = data.name
        contentView.exchangeIdLabel.text = data.exchangeId

        // MARK: - Metadata Section

        contentView.addRow(
            to: contentView.metadataSection,
            icon: UIImage(systemName: "globe"),
            title: "Website",
            value: data.website
        )

        contentView.addFormattedDateRow(
            to: contentView.metadataSection,
            icon: UIImage(systemName: "calendar.badge.clock"),
            title: "Quote Start",
            isoDate: data.dataQuoteStart
        )

        contentView.addFormattedDateRow(
            to: contentView.metadataSection,
            icon: UIImage(systemName: "calendar"),
            title: "Quote End",
            isoDate: data.dataQuoteEnd
        )

        contentView.addFormattedDateRow(
            to: contentView.metadataSection,
            icon: UIImage(systemName: "book"),
            title: "Orderbook Start",
            isoDate: data.dataOrderbookStart
        )

        contentView.addFormattedDateRow(
            to: contentView.metadataSection,
            icon: UIImage(systemName: "book.closed"),
            title: "Orderbook End",
            isoDate: data.dataOrderbookEnd
        )

        contentView.addFormattedDateRow(
            to: contentView.metadataSection,
            icon: UIImage(systemName: "arrow.left.arrow.right"),
            title: "Trade Start",
            isoDate: data.dataTradeStart
        )

        contentView.addFormattedDateRow(
            to: contentView.metadataSection,
            icon: UIImage(systemName: "arrow.right.arrow.left"),
            title: "Trade End",
            isoDate: data.dataTradeEnd
        )

        contentView.addRow(
            to: contentView.metadataSection,
            icon: UIImage(systemName: "number"),
            title: "Symbols Count",
            value: data.dataSymbolsCount.map { "\($0)" }
        )

        // MARK: - Volume Section

        contentView.addRow(
            to: contentView.volumeSection,
            icon: UIImage(systemName: "clock"),
            title: "Volume (1h USD)",
            value: data.volume1hrsUsd.map { "$\($0)" }
        )

        contentView.addRow(
            to: contentView.volumeSection,
            icon: UIImage(systemName: "calendar.day.timeline.left"),
            title: "Volume (1d USD)",
            value: data.volume1dayUsd.map { "$\($0)" }
        )

        contentView.addRow(
            to: contentView.volumeSection,
            icon: UIImage(systemName: "calendar"),
            title: "Volume (1m USD)",
            value: data.volume1mthUsd.map { "$\($0)" }
        )
    }
}
