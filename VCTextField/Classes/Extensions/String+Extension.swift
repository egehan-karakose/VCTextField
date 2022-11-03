//
//  String+Extension.swift
//  VTextField
//
//  Created by Egehan KARAKÖSE (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 2.09.2022.
//

import Foundation

extension String {
    
    var trimWhitespaces: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var removingSpaces: String {
        return self.filter { !" \n\t\r".contains($0) }
    }
    
    var getNumbers: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var intValue: Int {
        return Int(self) ?? 0
    }
    
    func doubleValue() -> Double? {
        
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    public func replacingInverted(of characterSet: CharacterSet?, with string: String) -> String {
        guard let characterSet = characterSet else { return self }
        return self.components(separatedBy: characterSet.inverted).joined(separator: string)
    }
    
    public func removingLeadingSpaces() -> String {
        if self == " " {
            return ""
        }
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
            return self
        }
        return String(self[index...])
    }
    
}
