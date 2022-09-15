//
//  UIViewController+Debug.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import UIKit

extension UIViewController {
    func logDeinit() {
        print(String(describing: type(of: self)) + " deinit")
    }
}

extension UIViewController {
    func showError(_ error: Error, completion: (() -> Void)? = nil) {
        let ac = UIAlertController(title: "Error",
                                   message: error.localizedDescription,
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
}
