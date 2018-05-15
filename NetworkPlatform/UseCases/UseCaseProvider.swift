import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makeJokesUseCase() -> Domain.JokesUseCase {
        return JokesUseCase(network: networkProvider.makeJokesNetwork(),
                            cache: Cache<Joke>(path: "allJokes"))
    }
}
