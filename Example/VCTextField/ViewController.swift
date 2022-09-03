//
//  ViewController.swift
//  VCTextField
//
//  Created by egehan205 on 09/03/2022.
//  Copyright (c) 2022 egehan205. All rights reserved.
//

import UIKit
import VCTextField

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    var email: String?
    var password: String?
    var password2: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboardActionWhenTappedAround()
        
        let emailFieldModel = VCTextFieldViewModel(placeholder: "E-mail")
        emailFieldModel.createDemoself()
        let emailRegex = "^([0-9a-zA-Z-_]([!#$%&'*+-\\/=?^_`{|}~.-.\\w]*[0-9a-zA-Z-_])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})$"
        /// Validator Class
        /**
                        
         RequiredValidator
         TrimRequiredValidator
         CreditCardNumberValidator
         MinimumLengthValidator
         MinimumValueValidator
         MaximumValueValidator
         PhoneNumberValidator
         OnlyNumbersValidator
         RegexValidator
         TransactionDayValidator
         ConsecutiveNumbersValidator
         FunctionValidator
         ExpectedValueValidator
         PlateValidator
         
         **/
        emailFieldModel.validators = [RequiredValidator(placeHolder: "E-mail"),
                                         RegexValidator(regex: emailRegex, placeholder: "E-mail")]
        emailFieldModel.textChangeHandler = {[weak self] value in
            self?.email = value
        }
        let emailField = VCTextField(viewModel: emailFieldModel)

        let demoPasswordFieldViewModel = VCTextFieldViewModel(placeholder: "Password")
        demoPasswordFieldViewModel.createDemo3self()
        demoPasswordFieldViewModel.validators = [RequiredValidator(placeHolder: "Password")]
        demoPasswordFieldViewModel.contentType = .password
        demoPasswordFieldViewModel.textChangeHandler = {[weak self] value in
            self?.password = value
        }
        let demoPasswordField = VCTextField(viewModel: demoPasswordFieldViewModel)
        
        
        let demoPasswordTextFieldModel = VCTextFieldViewModel(placeholder: "Password")
        demoPasswordTextFieldModel.createDemo2self()
        demoPasswordTextFieldModel.validators = [RequiredValidator(placeHolder: "Password")]
        demoPasswordTextFieldModel.contentType = .password
        demoPasswordTextFieldModel.textChangeHandler = {[weak self] value in
            self?.password2 = value
        }
        let demoPasswordTextField = VCTextField(viewModel: demoPasswordTextFieldModel)
        
        // to set text
        demoPasswordTextField.setText(text: "asdasd")

        stackView.addArrangedSubViews(views: [emailField, demoPasswordField, demoPasswordTextField])
        stackView.layoutIfNeeded()
        
    }

}

extension UIViewController {
    
    func initializeHideKeyboardActionWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
            self?.view.endEditing(true)
        }
    }
}

