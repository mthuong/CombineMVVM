//
//  RepoDetailViewModel.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/16/22.
//

import Combine
import Foundation

class RepoDetailViewModel: ViewModelType {
    init(_ useCase: RepoDetailUseCaseType, _ router: RepoDetailRouterType, _ fullName: String) {
        self.useCase = useCase
        self.router = router
        self.fullName = fullName
    }
    
    struct Input {
        let loadTrigger: AnyPublisher<Void, Never>
    }
    
    final class Output: ObservableObject {
        @Published var repo: Repo?
        @Published var isLoading = false
        @Published var error: Error?
    }
    
    // MARK: Properties
    private let fullName: String
    private let router: RepoDetailRouterType!
    private let useCase: RepoDetailUseCaseType!
    private(set) var output: Output!
    private let errorTracker = ErrorTracker()
    private let activityTracker = ActivityTracker(false)
    
    internal var subscriptions: Set<AnyCancellable> = Set()
    
    deinit {
        logDeinit()
    }
    
    func transform(_ input: Input) -> Output {
        let output = Output()
        self.output = output
        
        input.loadTrigger
            .sink { [weak self] in
                self?.getRepoDetailAction()
            }
            .store(in: &subscriptions)
        
        activityTracker
            .assign(to: \.isLoading, on: output)
            .store(in: &subscriptions)
        
        errorTracker
            .mapToOptional()
            .assign(to: \.error, on: output)
            .store(in: &subscriptions)
        
        return output
    }
}

// MARK: - Handle data
private extension RepoDetailViewModel {
    func getRepoDetailAction() -> Void {
        self.useCase
            .getRepoDetail(self.fullName)
            .trackError(errorTracker)
            .trackActivity(activityTracker)
            .catch { _ in
                Empty()
            }
            .sink(receiveValue: { [weak self] repo in
                self?.output.repo = repo
            })
            .store(in: &subscriptions)
    }
}
