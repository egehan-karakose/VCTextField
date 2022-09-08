# VCTextField

[![CI Status](https://img.shields.io/travis/egehan205/VCTextField.svg?style=flat)](https://travis-ci.org/egehan205/VCTextField)
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
```ruby
override func viewDidLoad() {
        let demoFloatingTextFieldModel = VCTextFieldViewModel(placeholder: "Floating Label")
        demoFloatingTextFieldModel.createDareDiceTextFieldViewModelWithFloat()
        demoFloatingTextFieldModel.validators = [RequiredValidator(placeHolder: "Label")]
        let demoFloatingText = VCTextField(viewModel: demoFloatingTextFieldModel)
        stackView.addArrangedSubViews(views: [demoFloatingText])
        stackView.layoutIfNeeded()
  }
```
tf_ --> TextField properties
```ruby
func createDareDiceTextFieldViewModelWithFloat() {
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

## Author

Egehan Karaköse, egehankarakose@gmail.com

## License

VCTextField is available under the MIT license. See the LICENSE file for more info.
