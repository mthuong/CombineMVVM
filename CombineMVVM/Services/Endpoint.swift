//
//  Endpoint.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

enum Endpoint {
    static let BASE_URL = "https://api.github.com/"
    
    case searchRepos
    case fetchRepo(path: String)
    
    func path() -> String {
        switch self {
        case .searchRepos:
            return "search/repositories"
        case .fetchRepo(let path):
            return "repos/\(path)"
        }
    }
}
