//
//  Endpoint.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

enum Endpoint {
    static let BASE_URL = "https://api.github.com/"
    
    case searchRepos
    
    func path() -> String {
        switch self {
        case .searchRepos:
            return "search/repositories"
        }
    }
}
