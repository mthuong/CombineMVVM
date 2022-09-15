//
//  Publisher+Extension.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import Combine

extension Publisher {
    func mapToOptional() -> AnyPublisher<Output?, Failure> {
        map { value -> Output? in value }.eraseToAnyPublisher()
    }
    
    func unwrap() -> AnyPublisher<Output, Failure> {
        compactMap { value -> Output in value }.eraseToAnyPublisher()
    }
}
