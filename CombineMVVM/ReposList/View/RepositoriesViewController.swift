//
//  RepositoriesViewController.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import Foundation
import UIKit
import Combine

final class RepositoriesViewController: UIViewController, BindableType {
    init(_ vm: RepositoriesViewModel) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Views
    enum Section: Hashable {
        case main
    }
    
    private let tableView: UITableView = {
        let tbv = UITableView()
        tbv.translatesAutoresizingMaskIntoConstraints = false
        tbv.register(ofType: RepoCell.self)
        return tbv
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.isUserInteractionEnabled = false
        return searchController
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.isHidden = true
        indicator.startAnimating()
        return indicator
    }()
    
    // MARK: Properties
    var viewModel: RepositoriesViewModel!
    
    private let searchTextTrigger = PassthroughSubject<String, Never>()
    private let selectRepoTrigger = PassthroughSubject<IndexPath, Never>()
    
    private lazy var dataSource: UITableViewDiffableDataSource<Section, Repo>! = {
        let datasource = UITableViewDiffableDataSource<Section, Repo>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, repo: Repo) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(ofType: RepoCell.self, at: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.configCell(repo)
            return cell
        }
        datasource.defaultRowAnimation = .fade
        return datasource
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: Methods
    private func setupView() {
        self.title = "Repositories"
        
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.view.addSubview(activityIndicator)
        
        tableView.delegate = self
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    func bindViewModel() {
        let input = RepositoriesViewModel.Input(
//            loadTrigger: Just(()).eraseToAnyPublisher(),
            searchTextTrigger: searchTextTrigger
                .debounce(for: 0.3, scheduler: RunLoop.main)
                .filter({ text in
                    !text.isEmpty
                })
                .eraseToAnyPublisher(),
            selectRepoTrigger: selectRepoTrigger.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(input)
        
        output.$repos
            .subscribe(reposSubscriber)
        
        output.$isLoading
            .subscribe(loadingSubscriber)
        
        output.$error
            .subscribe(errorSubscriber)
    }
    
}

// MARK: - Subscribers
extension RepositoriesViewController {
    private var reposSubscriber: Binder<[Repo]> {
        Binder(self) { vc, repos in
            var snapshot = NSDiffableDataSourceSnapshot<Section, Repo>()
            snapshot.appendSections([.main])
            snapshot.appendItems(repos, toSection: .main)
            vc.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
            DispatchQueue.main.async {
                vc.tableView.isHidden = repos.isEmpty
            }
        }
    }
    
    private var loadingSubscriber: Binder<Bool> {
        Binder(self) { vc, isLoading in
            DispatchQueue.main.async {
                vc.activityIndicator.isHidden = !isLoading
                vc.searchController.searchBar.isUserInteractionEnabled = !isLoading
            }
        }
    }
    
    private var errorSubscriber: Binder<Error?> {
        Binder(self) { vc, error in
            guard let error = error else { return }
            vc.showError(error, completion: nil)
        }
    }
}

// MARK: UITableViewDelegate
extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UISearchBarDelegate
extension RepositoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextTrigger.send(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchTextTrigger.send("")
    }
}

// MARK: - UIScrollViewDelegate
extension RepositoriesViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
}
