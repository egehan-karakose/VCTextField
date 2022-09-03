//
//  TextFieldWithInsets.swift
//  VTextField
//
//  Created by Egehan KARAKÖSE (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 2.09.2022.
//

import Foundation

public class TextFieldWithInsetsViewModel {
    public var padding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    public var textChangedHandler: ((_ newValue: String?) -> Void)?
    public var textEndEditingHandler: ((_ newValue: String?) -> Void)?
    public var textBeginEditingHandler: ((_ newValue: String?) -> Void)?
    public var allowedCharacters: CharacterSet?
    public var maxLength: Int = .max
    public var maskString: String?
    public var cornerRadius: CGFloat?
    public var font: UIFont?
    public var backgroundColor: UIColor?
    public var textColor: UIColor?
    public let placeHolder: String
    public var tintColor: UIColor?
    public var borderWidth: CGFloat?
    public var borderColor: CGColor?
    public var placeHolderColor: UIColor?
    public var height: CGFloat?
    
    init(placeHolder: String) {
        self.placeHolder = placeHolder
    }

}

public class TextFieldWithInsets: UITextField {

    let viewModel: TextFieldWithInsetsViewModel
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: viewModel.padding.left, dy: viewModel.padding.top)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: viewModel.padding.left, dy: viewModel.padding.top)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: viewModel.padding.left, dy: viewModel.padding.top)
    }
    
    public init(viewModel: TextFieldWithInsetsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureTextField() {
        
        tintColor = viewModel.tintColor   // .appMainBackgroundColor
        layer.borderWidth = viewModel.borderWidth ?? 1 //1
        clipsToBounds = true
        layer.borderColor = viewModel.borderColor  //UIColor.labelBackground.cgColor
        layer.cornerRadius = viewModel.cornerRadius ?? 15
        font = viewModel.font //UIFont.regular(of: 14)
        backgroundColor = viewModel.backgroundColor // .labelBackground
        textColor = viewModel.textColor // .appTextBlack
        attributedPlaceholder = NSAttributedString(
            string: viewModel.placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: viewModel.placeHolderColor ?? UIColor.black] // UIColor.appTextGray
        )
        height(constant: viewModel.height ?? 48)
        self.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        self.addTarget(self, action: #selector(textEndEditing(_:)), for: .editingDidEnd)
        self.addTarget(self, action: #selector(textBeginEditing(_:)), for: .editingDidBegin)
    }
    
    public func setText(text: String) {
        self.text = text
    }
    
    @objc func textChanged(_ sender: Any?) {
        let newValue = self.text
        viewModel.textChangedHandler?(newValue)
    }
    
    @objc func textEndEditing(_ sender: Any?) {
        let newValue = self.text
        viewModel.textEndEditingHandler?(newValue)
    }
    
    @objc func textBeginEditing(_ sender: Any?) {
        let newValue = self.text
        viewModel.textBeginEditingHandler?(newValue)
    }
    
}

extension TextFieldWithInsets: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if !string.isEmpty && string.replacingInverted(of: viewModel.allowedCharacters, with: "").isEmpty {
            return false
        }
        
        let oldText = textField.text as NSString?
        var newText = oldText?.replacingCharacters(in: range, with: string)
        
        // check length
        if (newText?.count ?? 0) > viewModel.maxLength &&
            ((oldText?.length ?? 0) <= viewModel.maxLength || (viewModel.maskString ?? "").isEmpty == false || string == " " ) {
            newText = String(newText?.prefix((viewModel.maxLength)~) ?? "")
            
            if (viewModel.maskString ?? "").isEmpty == true && string.count == 1 && (oldText?.length ?? 0) <= viewModel.maxLength {
                return false
            } else if (oldText?.length ?? 0) > viewModel.maxLength && string == " " {
                textField.sanitizeText(newText, replacement: string)
                return false
                // bu kısım önerilen text seçilince ios 12 de sorun oluyor. string == " " bu kontrol hep onun için
            }
        }
        
        // remove unwanted characters
        newText = newText?.replacingInverted(of: viewModel.allowedCharacters, with: "")
        
        // apply mask
        if let maskString = viewModel.maskString {
            let mask = JMStringMask(mask: maskString)
            newText = mask.mask(string: newText) ?? newText
        }
        if string.count > 1 {
            textField.sanitizeText(newText, replacement: string)
            return false
        }
        
        return true
    }
    
}


