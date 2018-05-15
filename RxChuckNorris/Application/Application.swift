import Foundation
import Domain
import NetworkPlatform

final class Application {
    static let shared = Application()

    let networkUseCaseProvider: Domain.UseCaseProvider

    private init() {
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }

    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let navigationController = UINavigationController()
        let navigator = DefaultJokesNavigator(services: networkUseCaseProvider,
                navigationController: navigationController,
                storyBoard: storyboard)
        window.rootViewController = navigationController

        navigator.toJokes()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            navigator.toCreateUser()
        })
    }
}
