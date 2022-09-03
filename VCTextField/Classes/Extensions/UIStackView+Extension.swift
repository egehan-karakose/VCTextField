//
//  UIStackView+Extension.swift
//  VTextField
//
//  Created by Egehan KARAKÖSE (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 2.09.2022.
//

import Foundation

public extension UIStackView {
    func clearArrangedSubviews() {
        for arrangedSubview in arrangedSubviews {
            removeArrangedSubview(arrangedSubview)
            arrangedSubview.removeFromSuperview()
        }
    }
    
    @discardableResult
    func removeAllArrangedSubviewsWithViews() -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
        return removedSubviews
    }
    
    func addArrangedSubViews(views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    func addArrangedSubViews(views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
