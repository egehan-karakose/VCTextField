//
//  BaseValidator.swift
//  VTextField
//
//  Created by Egehan KARAKÖSE (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 2.09.2022.
//

import Foundation

open class BaseValidator {
    
    /// Checks if given input string is between min and max interval
    ///
    /// - Parameters:
    ///   - minDouble: Minimum value as double
    ///   - maxDouble: Maximum value as double
    ///   - inputString: Input as string
    /// - Returns: True if input is between given interval
    public static func minMaxDouble(minDouble: Double?,
                                    maxDouble: Double?,
                                    inputString: String?) -> Bool {
        guard let minDouble = minDouble,
            let maxDouble = maxDouble,
            let inputString = inputString else {
                return false
        }
        
        let isMinValid = BaseValidator.minDouble(minDouble, inputString: inputString)
        let isMaxValid = BaseValidator.maxDouble(maxDouble, inputString: inputString)
        return isMinValid && isMaxValid
    }
    
    /// Checks if given input is not greater than maximum string
    ///
    /// - Parameters:
    ///   - maxString: Maximum value as double
    ///   - input: Input as string
    /// - Returns: True if input is not larger than the maximum
    public static func maxDouble(_ maxDouble: Double?,
                                 inputString: String?) -> Bool {
        guard let maxDouble = maxDouble,
            let inputString = inputString,
            let inputDouble = Double(inputString) else {
                return false
        }
        
        return maxDouble >= inputDouble
    }
    
    /// Checks if given input is not smaller than minimum string
    ///
    /// - Parameters:
    ///   - minString: Minimum value as double
    ///   - input: Input as string
    /// - Returns: True if input is not smaller than the minimum string
    public static func minDouble(_ minDouble: Double?,
                                 inputString: String?) -> Bool {
        guard let minDouble = minDouble,
            let inputString = inputString,
            let inputDouble = Double(inputString) else {
                return false
        }
        
        return minDouble <= inputDouble
    }
    
    /// Evaluates given regex on the input
    ///
    /// - Parameters:
    ///   - regex: Regex to apply
    ///   - input: Input string
    /// - Returns: True if input matches the regex
    public static func regex(_ regex: String,
                             input: String) -> Bool {
        
        let regex = try? NSRegularExpression(pattern: regex, options: .caseInsensitive)
        return regex?.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.count)) != nil
    }
}


