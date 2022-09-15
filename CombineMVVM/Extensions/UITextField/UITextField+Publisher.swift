//
//  UITextField+Publisher.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import UIKit
import Combine

extension UITextField {

    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextField)?.text }
        .eraseToAnyPublisher()
    }

}
