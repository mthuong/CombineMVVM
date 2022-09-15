//
//  BindableType.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import UIKit

protocol BindableType: AnyObject {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

