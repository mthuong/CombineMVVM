//
//  Publisher+ActivityTracker.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//
import Combine

typealias ActivityTracker = CurrentValueSubject<Bool, Never>

extension Publisher {
    func trackActivity(_ activityTracker: ActivityTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveSubscription: { _ in
            activityTracker.send(true)
        }, receiveCompletion: { _ in
            activityTracker.send(false)
        })
        .eraseToAnyPublisher()
    }
}
