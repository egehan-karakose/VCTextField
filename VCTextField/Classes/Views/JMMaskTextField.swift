//
//  JMMaskTextField.swift
//  VTextField
//
//  Created by Egehan KARAKÖSE (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 2.09.2022.
//

import Foundation

open class JMMaskTextField: UITextField {

    // damn, maskView is just mask in Swift
    public private(set) var stringMask: JMStringMask?
    fileprivate weak var realDelegate: UITextFieldDelegate?
    open var isAnimationDisabled: Bool = false
    var canDeletePrefix: Bool = false

    override weak open var delegate: UITextFieldDelegate? {
        get {
            return self.realDelegate
        }
        set (newValue) {
            self.realDelegate = newValue
            super.delegate = self
        }
    }
    
    public var unmaskedText: String? {
        return self.stringMask?.unmask(string: self.text) ?? self.text
    }
    
    @IBInspectable open var maskString: String? {
        didSet {
            guard let maskString = self.maskString else {
                self.stringMask = nil
                return
            }
            self.stringMask = JMStringMask(mask: maskString)
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.commonInit()
    }
    
    func commonInit() {
        super.delegate = self
    }
}

extension JMMaskTextField: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.realDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let mask = self.stringMask else {
            self.realDelegate?.textFieldDidBeginEditing?(textField)
            return
        }
        if self.text == "" {
            self.text = String((self.maskString?.prefix(mask.firstMaskedCharacterIndex()))!)
            sendActions(for: .editingChanged)
        }
        self.realDelegate?.textFieldDidBeginEditing?(textField)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // swiftlint:disable early_guard
        guard let mask = self.stringMask else {
            return self.realDelegate?.textFieldShouldEndEditing?(textField) ?? true
        }
        // swiftlint:enable early_guard
        if self.text == String((self.maskString?.prefix(mask.firstMaskedCharacterIndex()))!) {
            isAnimationDisabled = true
            self.text = ""
            sendActions(for: .editingChanged)
            isAnimationDisabled = false
        }
        return self.realDelegate?.textFieldShouldEndEditing?(textField) ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.realDelegate?.textFieldDidEndEditing?(textField)
    }
    
    // swiftlint:disable function_body_length
    // swiftlint:disable cyclomatic_complexity
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        
        let previousMask = self.stringMask
        let currentText: NSString = textField.text as NSString? ?? ""
        if let realDelegate = self.realDelegate, realDelegate.responds(to: #selector(textField(_:shouldChangeCharactersIn:replacementString:))) {
            let delegateResponse = realDelegate.textField!(textField, shouldChangeCharactersIn: range, replacementString: string)
            if !delegateResponse {
                return false
            }
        }
        
        guard let mask = self.stringMask else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        var formattedString = mask.mask(string: newText)
        if (previousMask != nil && mask != previousMask!) || formattedString == nil {
            formattedString = mask.mask(string: mask.unmask(string: newText))
        }
        
        guard var finalText = formattedString as NSString? else { return false }
        if finalText == currentText && range.location < currentText.length && range.location > 0 {
            return self.textField(textField, shouldChangeCharactersIn: NSRange(location: range.location - 1,
                                                                               length: range.length + 1), replacementString: string)
        }
        
        if finalText != currentText {
            var strCurrentValue = ""
            if currentText.length > 0 {
                strCurrentValue = String((maskString?.prefix(currentText.length))!)
            }
            var bLocationForMask = false
            if currentText.length > 0 && currentText as String == strCurrentValue && finalText.length < currentText.length {
                if canDeletePrefix {
                    return true
                } else {
                    textField.text = currentText as String
                    sendActions(for: .editingChanged)
                    bLocationForMask = true
                }
                
            } else {
                if (finalText as String).isEmpty {
                    finalText = (self.maskString?.prefix(mask.firstMaskedCharacterIndex()) as NSString? ?? NSString())
                    textField.text = finalText as String
                    sendActions(for: .editingChanged)
                    return false
                } else {
                    textField.text = finalText as String
                    sendActions(for: .editingChanged)
                }
            }
            
            if range.location < currentText.length {
                var cursorLocation = 0
                if bLocationForMask {
                    cursorLocation = currentText.length
                } else if range.location > finalText.length {
                    cursorLocation = finalText.length
                } else if currentText.length > finalText.length {
                    cursorLocation = range.location
                } else {
                    if finalText.substring(with: NSRange(location: range.location, length: 1)) == " " {
                        cursorLocation = range.location + 2
                    } else {
                        cursorLocation = range.location + 1
                    }
                }
                
                guard let startPosition = textField.position(from: textField.beginningOfDocument, offset: cursorLocation) else { return false }
                guard let endPosition = textField.position(from: startPosition, offset: 0) else { return false }
                textField.selectedTextRange = textField.textRange(from: startPosition, to: endPosition)
            }
            return false
        } else if newText != currentText as String { return false }
        return true
    }
    // swiftlint:enable cyclomatic_complexity

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self.realDelegate?.textFieldShouldClear?(textField) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.realDelegate?.textFieldShouldReturn?(textField) ?? true
    }
    
    open override func paste(_ sender: Any?) {
        if let string = UIPasteboard.general.string, let range = selectedRange {
            _ = textField(self, shouldChangeCharactersIn: range, replacementString: string)
        }
    }
}

extension UITextField {
    
    func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    @objc private func doneButtonAction() {
        self.endEditing(true)
    }
}

extension UITextInput {
    var selectedRange: NSRange? {
        guard let range = selectedTextRange else { return nil }
        let location = offset(from: beginningOfDocument, to: range.start)
        let length = offset(from: range.start, to: range.end)
        return NSRange(location: location, length: length)
    }
}
