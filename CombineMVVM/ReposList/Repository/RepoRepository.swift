//
//  RepoRepository.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import Combine

struct RepoResponse: Decodable {
    private(set) var items: [Repo]?
}

protocol RepoRepositoryType {
    func searchRepositories(query: String?) -> AnyPublisher<RepoResponse, APIError>
}

class RepoRepository: RepoRepositoryType {
    func searchRepositories(query: String?) -> AnyPublisher<RepoResponse, APIError> {
        var search = ""
        if let query = query {
            search = query
        }
        
        return API.shared
            .request(endpoint: .searchRepos,
                     httpMethod: .GET,
                     params: [
                        "q": search,
                        "order": "desc"
                     ])
    }
}
