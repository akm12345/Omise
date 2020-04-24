//
//  OMCharityDonationViewController.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import UIKit
import OmiseSDK

class OMCharityDonationViewController: OMBaseViewController {
    
    //MARK:- IBoutlets
    @IBOutlet weak var donationAmountTextField: BindingTextField!
    @IBOutlet weak var charityNameLabel: UILabel!
    
    //MARK:- Instance variables
        var charityName: String?
        let publicKey = ktestPublicKey
        var donationViewModel = DonationViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setUpViewModelAndBinding()
        }
        
        func setUpViewModelAndBinding(){
            if let charityName = charityName{
                self.donationViewModel.charityName = charityName
            }
            self.donationAmountTextField.bind {
                self.donationViewModel.amount = $0
            }
        }
        
        @IBAction func donateAmount(_ sender: Any) {
            displayCreditCardForm()
        }
        
        func performTransaction(){
            self.showLoader()
            donationViewModel.donateAmount(completion: { (success, errorMessage) in
                self.hideLoader()
                if let errorMessage = errorMessage{
                    self.showAlert(message: errorMessage)
                }
                if success != nil{
                    self.performSegue(withIdentifier: "OMTransactionSuccessViewController", sender: nil)
                }
            })
        }
        
        func displayCreditCardForm() {
            let creditCardView = CreditCardFormViewController.makeCreditCardFormViewController(withPublicKey: publicKey)
            creditCardView.delegate = self
            creditCardView.handleErrors = true
            present(creditCardView, animated: true, completion: nil)
        }
    }

    extension OMCharityDonationViewController: CreditCardFormViewControllerDelegate {
        func creditCardFormViewController(_ controller: CreditCardFormViewController, didSucceedWithToken token: Token) {
            self.dismiss(animated: true) {
                self.donationViewModel.token = token.id
                self.performTransaction()
            }
        }
        
        func creditCardFormViewController(_ controller: CreditCardFormViewController, didFailWithError error: Error) {
            self.showAlert(message: error.localizedDescription)
        }
        
        func creditCardFormViewControllerDidCancel(_ controller: CreditCardFormViewController) {
            self.dismiss(animated: true, completion: nil)
        }
    }
