//
//  RepoDetailRouter.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/16/22.
//

import Foundation
import UIKit

protocol RepoDetailRouterType: RouterType {
    func goBack()
}

class RepoDetailRouter: RepoDetailRouterType {
    weak var viewController: UIViewController?
    
    static func createModule(_ fullName: String) -> RepoDetailViewController {
        let router = RepoDetailRouter()
        let vm = RepoDetailViewModel(RepoDetailUseCase(repoDetailRepository: RepoDetailRepository()), router, fullName)
        let vc = RepoDetailViewController(vm)
        return vc
    }
    
    deinit {
        logDeinit()
    }
}

extension RepoDetailRouter {
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
