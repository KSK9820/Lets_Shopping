//
//  Binding.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import Foundation

final class Binding<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
