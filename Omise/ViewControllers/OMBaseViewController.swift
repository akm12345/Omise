//
//  OMBaseViewController.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import UIKit

let loaderTag = 12313435

///This is base view controller class and will include basic functions like showing alerts and toasts, all the view controllers needed t
class OMBaseViewController: UIViewController {
    
    //MARK:- Instance variables
    var loaderOn = false
    
    //MARK:- View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Alerts
    func showAlert(message: String?) {
        showAlert(title: omiseAlertTitle, message: message)
    }
    
    func showAlert(title: String?, message: String?) {
        showAlert(title: title, message: message, actionTitle: msgOk)
    }
    
    func showAlert(title: String?, message: String?, actionTitle: String?) {
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        let alert = createAlert(title: title, message: message, actions: [action])
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message: String?, completion: (()->Void)?) {
        let action = UIAlertAction(title: msgOk, style: .default) { (alertAction) in
            if let completion = completion {
                completion()
            }
        }
        let alert = createAlert(title: omiseAlertTitle, message: message, actions: [action])
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertWithTwoOptions(
        message:String?,
        title: String?,
        postiveOption: String? = msgOk,
        negativeOption: String? = msgCancel,
        completion: ((_ isPositive: Bool )-> Void)?) {
        let useAction = UIAlertAction(title: postiveOption, style: .default) { (alertAction) in
            if let completion = completion {
                completion(true)
            }
        }
        let cancelAction = UIAlertAction(title: negativeOption, style: .default) { (alertAction) in
            if let completion = completion {
                completion(false)
            }
        }
        let alert = createAlert(title: title, message: message, actions: [useAction, cancelAction])
        self.present(alert, animated: true, completion: nil)
    }
    
    func createAlert(title: String?, message: String?, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        
        return alert
    }
    
    //MARK:- Loaders
    func showLoader(timeOut: TimeInterval = Double(kDefaultTimeOutInterval))
    {
        hideLoader()
        
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            let activity = UIActivityIndicatorView(style: .large)
            activity.color = .black
            activity.tag = loaderTag
            activity.frame = CGRect(origin: self.view.center, size: CGSize(width: 0, height: 0))
            self.view.addSubview(activity)
            activity.startAnimating()
            self.loaderOn = true
            self.perform(#selector(self.hideLoader), with: nil, afterDelay: timeOut)
        }
    }
    
    @objc func hideLoader() {
        DispatchQueue.main.async {
            if let activity = self.view.viewWithTag(loaderTag) {
                self.loaderOn = false
                self.view.isUserInteractionEnabled = true
                activity.removeFromSuperview()
            }
        }
    }
}
