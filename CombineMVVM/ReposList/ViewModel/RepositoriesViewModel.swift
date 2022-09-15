//
//  RepositoriesViewModel.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import Foundation
import Combine

class RepositoriesViewModel: ViewModelType {
    init(_ useCase: RepositoriesUseCaseType, _ router: RepositoriesRouterType) {
        self.useCase = useCase
        self.router = router
    }
    
    struct Input {
//        let loadTrigger: AnyPublisher<Void, Never>
        let searchTextTrigger: AnyPublisher<String, Never>
        let selectRepoTrigger: AnyPublisher<IndexPath, Never>
    }
    
    final class Output: ObservableObject {
        @Published var repos = [Repo]()
        @Published var isLoading = false
        @Published var error: Error?
    }
    
    private let router: RepositoriesRouterType
    private let useCase: RepositoriesUseCaseType
    internal var subscriptions: Set<AnyCancellable> = Set()
    
    func transform(_ input: Input) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        
//        input.loadTrigger
//            .flatMap {
//                self.useCase
//                    .getRepositories(query: nil)
//                    .trackError(errorTracker)
//                    .trackActivity(activityTracker)
//                    .catch { _ in Empty() }
//                    .eraseToAnyPublisher()
//            }
//            .assign(to: \.repos, on: output)
//            .store(in: &subscriptions)
        
        input.searchTextTrigger
            .flatMap { text in
                self.useCase
                    .getRepositories(query: text)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .catch { _ in
                        Empty()
                    }
                    .eraseToAnyPublisher()
            }
            .assign(to: \.repos, on: output)
            .store(in: &subscriptions)
        
        input.selectRepoTrigger
            .sink {
                let repo = output.repos[$0.row]
                self.router.toRepoDetail(repo: repo)
            }
            .store(in: &subscriptions)
        
        activityTracker
            .assign(to: \.isLoading, on: output)
            .store(in: &subscriptions)
        
        errorTracker
            .receive(on: RunLoop.main)
            .mapToOptional()
            .assign(to: \.error, on: output)
            .store(in: &subscriptions)
        
        return output
    }
}
