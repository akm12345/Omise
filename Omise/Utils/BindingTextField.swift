//
//  BindingTextField.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import Foundation
import UIKit

/// This is used to implement data binding from textfield to its associated view model. whenever the value of textfield changes, the view model gets notified automatically.
class BindingTextField : UITextField {
    
    var textChanged :(String) -> () = { _ in }
    
    func bind(callback: @escaping (String) -> ()) {
        self.textChanged = callback
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField :UITextField) {
        self.textChanged(textField.text!)
    }
}
