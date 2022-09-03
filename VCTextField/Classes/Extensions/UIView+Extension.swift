//
//  UIView+Extension.swift
//  VTextField
//
//  Created by Egehan KARAKÖSE (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 2.09.2022.
//

import Foundation

extension UIView {
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.duration = 1
        animation.values = [-10, 10, -10, 10, -5, 5, -2.5, 2.5, 0]
        self.layer.add(animation, forKey: "shake")
    }
    
    func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }
    
    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }
    
    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        let constraint =
        NSLayoutConstraint(item: self,
                           attribute: attribute,
                           relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: nil,
                           attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                           multiplier: 1,
                           constant: value)
        self.addConstraint(constraint)
    }
    
    class func getAllSubviews<T: UIView>(from parenView: UIView) -> [T] {
        return parenView.subviews.flatMap { subView -> [T] in
            var result = getAllSubviews(from: subView) as [T]
            if let view = subView as? T { result.append(view) }
            return result
        }
    }

    class func getAllSubviews(from parenView: UIView, types: [UIView.Type]) -> [UIView] {
        return parenView.subviews.flatMap { subView -> [UIView] in
            var result = getAllSubviews(from: subView) as [UIView]
            for type in types {
                if subView.classForCoder == type {
                    result.append(subView)
                    return result
                }
            }
            return result
        }
    }

    func getAllSubviews<T: UIView>() -> [T] { return UIView.getAllSubviews(from: self) as [T] }
    func get<T: UIView>(all type: T.Type) -> [T] { return UIView.getAllSubviews(from: self) as [T] }
    func get(all types: [UIView.Type]) -> [UIView] { return UIView.getAllSubviews(from: self, types: types) }
    
    public func validateTextFields() -> Bool? {
         if let self = self as? VCTextField {
             return self.validate(true)
         }
         
         let mappedView = UIView.getAllSubviews(from: self)
        
         var isValid: [Bool] = []
         mappedView.forEach { view in
             if let view = view as? VCTextField {
                 isValid.append(view.validate(true) ?? true)
             }
         }
     
        return !isValid.contains(false)
     }
     
     public func clearValidationStates() {
         if let self = self as? VCTextField {
             self.clearValidation()
         }
         
         let mappedView = UIView.getAllSubviews(from: self)
         mappedView.forEach { view in
             if let view = view as? VCTextField {
                 view.clearValidation()
             }
         }
     }
    
}

