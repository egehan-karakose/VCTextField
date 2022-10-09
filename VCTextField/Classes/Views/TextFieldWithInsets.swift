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
    public var addUnderline: Bool?
    
    init(placeHolder: String) {
        self.placeHolder = placeHolder
    }

}

public class TextFieldWithInsets: UITextField {

    var bottomLine = CALayer()
    var borderColor: CGColor?
    let viewModel: TextFieldWithInsetsViewModel
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: viewModel.padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: viewModel.padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: viewModel.padding)
    }
    
    public init(viewModel: TextFieldWithInsetsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureTextField() {
        
        tintColor = viewModel.tintColor
        if let borderWidth = viewModel.borderWidth {
            layer.borderWidth = borderWidth
        }
        clipsToBounds = true
        if let borderColor = viewModel.borderColor {
            layer.borderColor = borderColor
        }
        
        if let cornerRadius = viewModel.cornerRadius {
            layer.cornerRadius = cornerRadius
        }

        font = viewModel.font //UIFont.regular(of: 14)
        if let backColor = viewModel.backgroundColor  {
            backgroundColor = backColor
        }
       
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if (viewModel.addUnderline)~ {
            addUnderline(borderColor ?? viewModel.placeHolderColor?.cgColor ?? UIColor.lightGray.cgColor)
        }
        
    }
    
    func addUnderline(_ withColor: CGColor) {
        removeUnderline()
        bottomLine.frame = CGRect(x: viewModel.padding.left, y: self.frame.height - 1, width: self.frame.width - (viewModel.padding.left * 2), height: 1)
        bottomLine.borderColor = withColor
        bottomLine.borderWidth = 1
        self.layer.addSublayer(bottomLine)
    }
    
    func removeUnderline() {
        bottomLine.removeFromSuperlayer()
    }
    
    @objc func textChanged(_ sender: Any?) {
        let newValue = self.text
        viewModel.textChangedHandler?(newValue)
    }
    
    @objc func textEndEditing(_ sender: Any?) {
        let newValue = self.text
        borderColor = viewModel.placeHolderColor?.cgColor
        viewModel.textEndEditingHandler?(newValue)
    }
    
    @objc func textBeginEditing(_ sender: Any?) {
        let newValue = self.text
        borderColor = viewModel.tintColor?.cgColor
        
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
        if string.count > 0 {
            textField.sanitizeText(newText, replacement: string)
            return false
        }
        
        return true
    }
    
}

