//
//  ViewModelType.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var subscriptions: Set<AnyCancellable> { get }
    
    func transform(_ input: Input) -> Output
}

extension ViewModelType {
    func logDeinit() -> Void {
        print(String(describing: type(of: self)) + " deinit")
    }
}
