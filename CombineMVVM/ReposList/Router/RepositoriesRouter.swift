//
//  RepositoriesRouter.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import Foundation
import UIKit

protocol RepositoriesRouterType {
    func toRepoDetail(repo: Repo)
}

struct RepositoriesRouter: RepositoriesRouterType {
    let navController: UINavigationController
    
    static func createModule() -> UINavigationController {
        let navController = UINavigationController()
        let router = RepositoriesRouter(navController: navController)
        let vm = RepositoriesViewModel(RepositoriesUseCase(repoRepository: RepoRepository()),
                                       router)
        let vc = RepositoriesViewController(vm)
        navController.setViewControllers([vc], animated: true)
        
        return navController
    }
    
    func toRepoDetail(repo: Repo) {
        // TODO: Implement navigate to repo detail
    }
}
