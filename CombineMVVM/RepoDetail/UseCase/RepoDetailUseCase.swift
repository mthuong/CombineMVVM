//
//  RepoDetailUseCase.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/16/22.
//

import Foundation
import Combine

protocol RepoDetailUseCaseType {
    func getRepoDetail(_ fullName: String) -> AnyPublisher<Repo, APIError>
}

struct RepoDetailUseCase: RepoDetailUseCaseType {
    let repoDetailRepository: RepoDetailRepositoryType
    
    func getRepoDetail(_ fullName: String) -> AnyPublisher<Repo, APIError> {
        repoDetailRepository
            .fetchRepoDetail(fullName)
            .eraseToAnyPublisher()
    }
}
