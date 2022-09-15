//
//  ViewController.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/14/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSubscriptions()
    }
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "...."
        return textField
    }()
    
    private let jobTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "job"
        return textField
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func loadView() {
        super.loadView()
        
        setupView()
    }
    
    private func setupView() {
        stack.addArrangedSubview(nameTextField)
        stack.addArrangedSubview(jobTextField)
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -16),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        stack
            .arrangedSubviews
            .forEach {
                $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
            }
    }
    
    private func setupSubscriptions() {
        nameTextField.textPublisher
            .sink { text in
                print(text)
            }
            .store(in: &cancellables)
    }
}

