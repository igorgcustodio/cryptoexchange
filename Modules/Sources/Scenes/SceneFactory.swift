import Foundation

public final class SceneFactory {
    let mainFactory: MainSceneBuilding
    let exchangeDetailsFactory: ExchangeDetailsSceneBuilding

    public init(
        mainFactory: MainSceneBuilding,
        exchangeDetailsFactory: ExchangeDetailsSceneBuilding
    ) {
        self.mainFactory = mainFactory
        self.exchangeDetailsFactory = exchangeDetailsFactory
    }
}
