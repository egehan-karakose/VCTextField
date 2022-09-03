//
//  JMStringMask.swift
//  VTextField
//
//  Created by Egehan KARAKÖSE (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 2.09.2022.
//

import Foundation

private struct Constants {
    static let letterMaskCharacter: Character = "_"
    static let numberMaskCharacter: Character = "-"
    static let defaulMaskCharacter: Character = "#"
    static let passwordMaskCharacter: Character = "*"
}

public struct JMStringMask: Equatable {
    
    var maskStr: String = ""
    
    private init() { }
    
    public init(mask: String) {
        self.init()
        
        self.maskStr = mask
    }
    
    public func mask(string: String?) -> String? {
        
        guard let string = string else { return nil }

        if string.count > self.maskStr.count {
            return nil
        }
        
        var formattedString = ""
        
        var currentMaskIndex = 0
        for iCount in 0..<string.count {
            if currentMaskIndex >= self.maskStr.count {
                return nil
            }
            
            let currentCharacter = string[string.index(string.startIndex, offsetBy: iCount)]
            var maskCharacter = self.maskStr[self.maskStr.index(string.startIndex, offsetBy: currentMaskIndex)]
            
            if currentCharacter == maskCharacter {
                formattedString.append(currentCharacter)
            } else {
                while maskCharacter != Constants.letterMaskCharacter
                    && maskCharacter != Constants.numberMaskCharacter
                    && maskCharacter != Constants.defaulMaskCharacter
                    && maskCharacter != Constants.passwordMaskCharacter
                    && currentCharacter != maskCharacter {
                    formattedString.append(maskCharacter)
                    //buradan devam et mask yapmaya.
                    currentMaskIndex += 1
                    maskCharacter = self.maskStr[self.maskStr.index(string.startIndex, offsetBy: currentMaskIndex)]
                }
                
                if currentCharacter == maskCharacter {
                    formattedString.append(currentCharacter)
                } else {
                    let isValidLetter = maskCharacter == Constants.letterMaskCharacter && self.isValidLetterCharacter(currentCharacter)
                    let isValidNumber = maskCharacter == Constants.numberMaskCharacter && self.isValidNumberCharacter(currentCharacter)
                    let isValid = maskCharacter == Constants.defaulMaskCharacter
                        && (self.isValidNumberCharacter(currentCharacter)
                        || self.isValidLetterCharacter(currentCharacter))

                    let isValidPass = maskCharacter == Constants.passwordMaskCharacter
                        && (self.isValidNumberCharacter(currentCharacter)
                            || self.isValidLetterCharacter(currentCharacter))
                    
                    if !isValid && !isValidLetter && !isValidNumber && !isValidPass {
                        return nil
                    }
                    if isValidPass {
                        formattedString.append(Constants.passwordMaskCharacter)
                    } else {
                        formattedString.append(currentCharacter)
                    }
                }
                
            }
            
            currentMaskIndex += 1
        }
        
        return formattedString
    }
    
    public func unmask(string: String?) -> String? {
        
        guard let string = string else { return nil }
        var unmaskedValue = ""
        
        for character in string {
            if self.isValidLetterCharacter(character) || self.isValidNumberCharacter(character) {
                unmaskedValue.append(character)
            }
        }
        
        return unmaskedValue
    }
    
    public func firstMaskedCharacterIndex() -> Int {
        
        for (index, char) in self.maskStr.enumerated() {
            if char == Constants.letterMaskCharacter || char == Constants.defaulMaskCharacter || char == Constants.numberMaskCharacter {
                return index
            }
        }
        
        return 0
    }
    
    private func isValidLetterCharacter(_ character: Character) -> Bool {

        let string = String(character)
        if string.unicodeScalars.count > 1 {
            return false
        }
        
        let lettersSet = NSCharacterSet.letters
        let unicodeScalars = string.unicodeScalars
        return lettersSet.contains(unicodeScalars[unicodeScalars.startIndex])
    }
    
    private func isValidNumberCharacter(_ character: Character) -> Bool {
        
        let string = String(character)
        if string.unicodeScalars.count > 1 {
            return false
        }
        
        let lettersSet = NSCharacterSet.decimalDigits
        let unicodeScalars = string.unicodeScalars
        return lettersSet.contains(unicodeScalars[unicodeScalars.startIndex])
    }
    
}

