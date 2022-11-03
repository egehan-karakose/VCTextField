//
//  ViewController.swift
//  VCTextField
//
//  Created by Egehan Karakose on 09/03/2022.
//  Copyright (c) 2022 Egehan Karakose. All rights reserved.
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
        
        let emailFieldModel = VCTextFieldViewModel(placeholder: "E-mail")
        emailFieldModel.createDemoself()
        let emailRegex = "^([0-9a-zA-Z-_]([!#$%&'*+-\\/=?^_`{|}~.-.\\w]*[0-9a-zA-Z-_])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})$"
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
        
        let demoFloatingTextFieldModel = VCTextFieldViewModel(placeholder: "Floating Label")
        demoFloatingTextFieldModel.createDareDiceTextFieldViewModelWithFloat()
        demoFloatingTextFieldModel.validators = [RequiredValidator(placeHolder: "Label")]
        let demoFloatingText = VCTextField(viewModel: demoFloatingTextFieldModel)

        stackView.addArrangedSubViews(views: [emailField , demoFloatingText, demoPasswordField])
        stackView.layoutIfNeeded()
        view.validateTextFields()
        
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo["UIKeyboardFrameEndUserInfoKey"] as? NSValue,
                      let currentTextField = UIResponder.currentFirst() as? TextFieldWithInsets else { return }

                // check if the top of the keyboard is above the bottom of the currently focused textbox
                let keyboardTopY = keyboardFrame.cgRectValue.origin.y
                let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
                let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

                // if textField bottom is below keyboard bottom - bump the frame up
                if textFieldBottomY > keyboardTopY {
                    let textBoxY = convertedTextFieldFrame.origin.y
                    let newFrameY = (textBoxY - keyboardTopY / 2) * -1
                    view.frame.origin.y = newFrameY
                }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

public extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }

    /// Finds the current first responder
    /// - Returns: the current UIResponder if it exists
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}
