//
//  UIButton+.swift
//  Growthook
//
//  Created by KJ on 11/4/23.
//

import UIKit

extension UIButton {
    
    func setUnderline() {
            guard let title = title(for: .normal) else { return }
            let attributedString = NSMutableAttributedString(string: title)
            attributedString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: title.count)
            )
            setAttributedTitle(attributedString, for: .normal)
        }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(minimumSize)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(origin: .zero, size: minimumSize))
        }
        
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.clipsToBounds = true
        self.setBackgroundImage(colorImage, for: state)
    }
    
    func makeRoundBorder(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor ) {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    
    
    func applyCornerRadiusToBottomCorners(radius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: bounds,
                                      byRoundingCorners: [.bottomLeft, .bottomRight],
                                      cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.mask = maskLayer
        /**
         좌우 하단에만 ConrnerRadius를 주는 func
         ex:
         button.applyCornerRadiusToBottomCorners(radius: 20)
         
         */
        
    }
}
