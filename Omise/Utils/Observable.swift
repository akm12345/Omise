//
//  Observable.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

/// This generic class is used to implement data binding and add observers as in MVVM. Any type conforming to this will gets notified whenever its value changes, with the use of closure.
class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    var valueChanged: ((T) -> Void)?
    var onErrorHandling : ((String) -> Void)?
    
    init(value: T) {
        self.value = value
    }
    
    /// Add closure as an observer and trigger the closure imeediately if fireNow = true
     func addObserver(fireNow: Bool = true, _ onChange: ((T) -> Void)?) {
         valueChanged = onChange
         if fireNow {
             onChange?(value)
         }
     }

    /// remove observers
     func removeObserver() {
         valueChanged = nil
     }
}
