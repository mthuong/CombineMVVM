//
//  RepoDetailViewController.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/16/22.
//

import Foundation
import Combine
import UIKit

class RepoDetailViewController: UIViewController, BindableType {
    init(_ vm: RepoDetailViewModel) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        logDeinit()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    func setupView() -> Void {
        
    }
    
    // MARK: Properties
    var viewModel: RepoDetailViewModel!
    private var subsciptions: Set<AnyCancellable> = Set()
    
    func bindViewModel() {
        let input = RepoDetailViewModel.Input(
            loadTrigger: Just(()).eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(input)
        
        output.$repo
            .receive(on: RunLoop.main)
            .sink { repo in
                guard let repo = repo else {
                    return
                }
                
                print(repo)
            }
            .store(in: &subsciptions)
        
        output.$isLoading
            .receive(on: RunLoop.main)
            .subscribe(loadingSubscriber)
        
        output.$error
            .receive(on: RunLoop.main)
            .subscribe(errorSubscriber)
    }
}

// MARK: - Subscribers
extension RepoDetailViewController {
    private var loadingSubscriber: Binder<Bool> {
        Binder(self) { vc, isLoading in
            print("isLoading \(isLoading)")
        }
    }
    
    private var errorSubscriber: Binder<Error?> {
        Binder(self) { vc, error in
            guard let error = error else { return }
            vc.showError(error, completion: nil)
        }
    }
}
