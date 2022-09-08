//
//  PreCreatedTextFields.swift
//  VTextField
//
//  Created by Egehan KARAKÖSE (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 2.09.2022.
//

import Foundation
import UIKit

public extension VCTextFieldViewModel {
    
    func createDemoself() {
        self.tf_placeHolderColor = .darkGray
        if #available(iOS 13.0, *) {
            self.tf_borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        self.tf_borderWidth = 1
        self.tf_tintColor = .red
        self.tf_backgroundColor = .gray
        self.tf_textColor = .black
        self.tf_font = UIFont(name: "Helvetica", size: 14)
        self.tf_height = 56
        self.validationTextFont = UIFont(name: "Helvetica", size: 12)
        self.validationTextColor = .red
    }
    
    func createDemo2self() {
        
        self.tf_placeHolderColor = .yellow
        if #available(iOS 13.0, *) {
            self.tf_borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        self.tf_borderWidth = 1
        self.tf_tintColor = .blue
        self.tf_cornerRadius = 30
        self.tf_backgroundColor = .orange
        self.tf_textColor = .white
        self.tf_font = UIFont(name: "Helvetica", size: 14)
        self.tf_height = 56
        self.validationTextFont = UIFont(name: "Helvetica", size: 12)
        self.validationTextColor = .orange
    }
    
    func createDemo3self()  {
        
        self.tf_placeHolderColor = .darkGray
        if #available(iOS 13.0, *) {
            self.tf_borderColor = CGColor(red: 20, green: 12, blue: 0, alpha: 1)
        }
        self.tf_borderWidth = 2
        self.tf_tintColor = .red
        self.tf_backgroundColor = .white
        self.tf_textColor = .red
        self.tf_font = UIFont(name: "Helvetica", size: 14)
        self.tf_height = 48
        self.validationTextFont = UIFont(name: "Helvetica", size: 12)
        self.validationTextColor = .blue
    }
    
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
    
}
