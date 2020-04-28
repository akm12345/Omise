//
//  OMExtensions.swift
//  Omise
//
//  Created by Amal Mishra on 28/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import UIKit
import Foundation

//MARK:- UITableView extension
extension UITableView {
    
    /// This method is used to set a custom text message letting user know that the table view is empty.
    func setEmptyTableView(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 20)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }

    /// This method removes the background view and set it to nil
    func restore() {
        self.backgroundView = nil
    }
}
