# VCTextField

[![CI Status](https://img.shields.io/travis/egehan-karakose/VCTextField.svg?style=flat)](https://travis-ci.org/egehan-karakose/VCTextField)
[![Version](https://img.shields.io/cocoapods/v/VCTextField.svg?style=flat)](https://cocoapods.org/pods/VCTextField)
[![License](https://img.shields.io/cocoapods/l/VCTextField.svg?style=flat)](https://cocoapods.org/pods/VCTextField)
[![Platform](https://img.shields.io/cocoapods/p/VCTextField.svg?style=flat)](https://cocoapods.org/pods/VCTextField)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

VCTextField is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'VCTextField'
```

## Examples
The properties starting with "tf_" refers to TextField.

You can use different kind of validator classes, there is a list of validators in example project (ViewController).

And also there is an UIView extention that allows check and show validators in anywhere in your code 

simply run; 

```swift
if view.validateTextFields() {
      // Add your code here
}
```

that will pop-up validations and return validation state of VCTextFields
```swift
override func viewDidLoad() {
        let demoFloatingTextFieldModel = VCTextFieldViewModel(placeholder: "Floating Label")
        demoFloatingTextFieldModel.createFloatingTextFieldViewModel()
        demoFloatingTextFieldModel.validators = [RequiredValidator(placeHolder: "Label")]
        let demoFloatingText = VCTextField(viewModel: demoFloatingTextFieldModel)
        stackView.addArrangedSubViews(views: [demoFloatingText])
        stackView.layoutIfNeeded()
  }
```

```swift
func createFloatingTextFieldViewModel() {
        self.tf_placeHolderColor = .lightGray
        self.tf_tintColor = .red
        self.tf_textColor = .black
        self.tf_font = UIFont(name: "Helvetica", size: 14)
        self.validationTextFont = UIFont(name: "Helvetica", size: 12)
        self.validationTextColor = .red
        self.tf_addUnderline = true
        self.isFloating = true
   }
```
![floating](https://user-images.githubusercontent.com/32635950/189193397-5bbf79fc-bcb4-4f1e-9635-295500cbba0d.gif)

```swift
override func viewDidLoad() {
        let emailFieldModel = VCTextFieldViewModel(placeholder: "E-mail")
        emailFieldModel.creatEmailTextField()
        let emailRegex = "^([0-9a-zA-Z-_]([!#$%&'*+-\\/=?^_`{|}~.-.\\w]*[0-9a-zA-Z-_])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})$"
        emailFieldModel.validators = [RequiredValidator(placeHolder: "E-mail"),
                                      RegexValidator(regex: emailRegex, placeholder: "E-mail")]
        emailFieldModel.textChangeHandler = {[weak self] value in
            self?.email = value
        }
        let emailField = VCTextField(viewModel: emailFieldModel)
        stackView.addArrangedSubViews(views: [emailField])
        stackView.layoutIfNeeded()
  }
```

```swift
func creatEmailTextField() {
        self.tf_placeHolderColor = .darkGray
        if #available(iOS 13.0, *) {
            self.tf_borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        self.tf_cornerRadius = 15
        self.tf_borderWidth = 1
        self.tf_tintColor = .red
        self.tf_backgroundColor = .lightGray
        self.tf_textColor = .black
        self.tf_font = UIFont(name: "Helvetica", size: 14)
        self.tf_height = 56
        self.validationTextFont = UIFont(name: "Helvetica", size: 12)
        self.validationTextColor = .blue
    }
```
![email](https://user-images.githubusercontent.com/32635950/189195411-fcb61487-006a-4863-8d0f-1116fea2bb82.gif)


## Author

Egehan Karaköse, egehankarakose@gmail.com

## License

VCTextField is available under the MIT license. See the LICENSE file for more info.
