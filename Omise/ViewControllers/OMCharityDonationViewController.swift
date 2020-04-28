//
//  OMCharityDonationViewController.swift
//  Omise
//
//  Created by Amal Mishra on 23/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import UIKit
import OmiseSDK

///This class is responsible for taking donation amount and performing transaction using OmiseSDK
class OMCharityDonationViewController: OMBaseViewController {
    
    //MARK:- IBoutlets
    @IBOutlet weak var donationAmountTextField: BindingTextField!
    @IBOutlet weak var charityNameLabel: UILabel!
    
    //MARK:- Instance variables
    var charityName: String?
    let publicKey = ktestPublicKey
    var donationViewModel = DonationViewModel()
    
    //MARK:- View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModelAndBinding()
        setUpTextFieldsAndDelegates()
    }
    
    //MARK:- IBAction methods
    @IBAction func donateAmount(_ sender: Any) {
        self.view.endEditing(true)
        let validationStatus = donationViewModel.validateEntries()
        switch validationStatus {
        case .valid:
            displayCreditCardForm()
        case .invalid(let validationErrorMessage):
            showAlert(message: validationErrorMessage)
        }
    }
    
    //MARK:- Instance methods
    
    ///Binds the label and textfield to the view model. When textfield value changes, it updates the view model automatically
    func setUpViewModelAndBinding(){
        if let charityName = charityName{
            donationViewModel.charityName = charityName
        }
        self.donationAmountTextField.bind {
            self.donationViewModel.amount = $0
        }
    }
    
    ///Set textfield deleagate and charity label text
    func setUpTextFieldsAndDelegates(){
        donationAmountTextField.delegate = self
        charityNameLabel.text = donationViewModel.charityName
    }
    
    ///This method is used to perform donation
    func performTransaction(){
        showLoader()
        donationViewModel.donateAmount(completion: { (success, errorMessage) in
            self.hideLoader()
            if let errorMessage = errorMessage{
                self.showAlert(message: errorMessage)
            }
            if success != nil{
                self.performSegue(withIdentifier: String(describing: OMTransactionSuccessViewController.self), sender: nil)
            }
        })
    }
    
    ///This methods opens the Omise Credit Card View Controller
    func displayCreditCardForm() {
        let creditCardView = CreditCardFormViewController.makeCreditCardFormViewController(withPublicKey: publicKey)
        creditCardView.delegate = self
        creditCardView.handleErrors = true
        present(creditCardView, animated: true, completion: nil)
    }
}

//MARK:- CreditCardFormViewControllerDelegate methods
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

//MARK:- UITextFieldDelegate methods
extension OMCharityDonationViewController: UITextFieldDelegate{
    
    ///Accept only decimal digits for donation textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == donationAmountTextField{
            let allowedCharacters = CharacterSet(charactersIn: kAllowedCharacterSetForDonationAnount)
            let characterSet = CharacterSet(charactersIn: string)
            if (!allowedCharacters.isSuperset(of: characterSet)){
                return false
            }
        }
        return true
    }
    
    //End editing when user taps outside of textfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
