//
//  RouterType.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/16/22.
//

import Foundation

protocol RouterType {
    
}

extension RouterType {
    func logDeinit() -> Void {
        print(String(describing: type(of: self)) + " deinit")
    }
}
