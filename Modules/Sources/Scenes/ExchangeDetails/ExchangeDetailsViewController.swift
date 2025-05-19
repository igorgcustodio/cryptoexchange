import CoreUI
import UIKit

public final class ExchangeDetailsViewController: LoadableViewController<ExchangeDetailsView> {

    private let viewModel: ExchangeDetailsViewModelProtocol

    public init(viewModel: ExchangeDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
}
