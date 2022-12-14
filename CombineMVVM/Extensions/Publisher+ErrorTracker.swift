//
//  Publisher+ErrorTrack.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import Combine

typealias ErrorTracker = PassthroughSubject<Error, Never>

extension Publisher {
    func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .eraseToAnyPublisher()
    }
}
