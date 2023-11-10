//
//  UIStackView+.swift
//  Growthook
//
//  Created by KJ on 11/4/23.
//

import UIKit

extension UIStackView {
    
     func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
}
