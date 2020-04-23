//
//  Observable.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation

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

     func removeObserver() {
         valueChanged = nil
     }
}
