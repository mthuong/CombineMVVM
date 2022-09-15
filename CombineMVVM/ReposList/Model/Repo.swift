//
//  Repository.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import Foundation

struct User: Decodable {
    var id: Int64?
    var login: String?
    var avatarUrl: URL?
}

struct Repo: Decodable {
    var id: Int?
    var updatedAt: Date?
    var createdAt: Date?
    var name: String?
    var description: String?
    var fullName: String?
    var htmlUrl: String?
    var stargazersCount: Int?
    var forks: Int?
    var language: String?
    var owner: User?
}

extension Repo: Equatable, Identifiable {
    static func == (lhs: Repo, rhs: Repo) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Repo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(fullName)
    }
}
