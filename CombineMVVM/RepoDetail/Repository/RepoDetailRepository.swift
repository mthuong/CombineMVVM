//
//  RepoDetailRepository.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/16/22.
//

import Foundation
import Combine

protocol RepoDetailRepositoryType {
    func fetchRepoDetail(_ fullName: String) -> AnyPublisher<Repo, APIError>
}

class RepoDetailRepository: RepoDetailRepositoryType {
    func fetchRepoDetail(_ fullName: String) -> AnyPublisher<Repo, APIError> {
        return API.shared
            .request(endpoint: .fetchRepo(path: "\(fullName)"),
                     httpMethod: .GET)
    }
}
