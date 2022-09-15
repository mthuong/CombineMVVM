//
//  RepositoriesUseCase.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import Foundation
import Combine

protocol RepositoriesUseCaseType {
    func getRepositories(query: String?) -> AnyPublisher<[Repo], APIError>
}

struct RepositoriesUseCase: RepositoriesUseCaseType {
    var repoRepository: RepoRepositoryType
    
    func getRepositories(query: String?) -> AnyPublisher<[Repo], APIError> {
        repoRepository.searchRepositories(query: query)
            .map { $0.items ?? [] }
            .eraseToAnyPublisher()
    }
}
