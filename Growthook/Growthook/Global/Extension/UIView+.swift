//
//  UIView+.swift
//  Growthook
//
//  Created by KJ on 11/4/23.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
    func makeShadow (radius : CGFloat, offset : CGSize, opacity : Float){
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func makeCornerRound (radius : CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func makeBorder (width : CGFloat ,color : UIColor ) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    func showToast(message: String) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = .gray500
        toastLabel.textColor = .green100
        toastLabel.textAlignment = .left
        toastLabel.font = .fontGuide(.body3_reg)
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = SizeLiterals.Screen.screenHeight * 50.0 / 812 / 2
        toastLabel.clipsToBounds = true
        let leadingImage = NSTextAttachment(image: ImageLiterals.Component.icn_check_green)
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "       "))
        attributedString.append(NSAttributedString(attachment: leadingImage))
        attributedString.append(NSAttributedString(string: "  \(message)"))
        toastLabel.attributedText = attributedString
        
        let toastWidth = SizeLiterals.Screen.screenWidth - 38 * 2.0
        let toastHeight = SizeLiterals.Screen.screenHeight * 50.0 / 812
        toastLabel.frame = CGRect(x: SizeLiterals.Screen.screenWidth/2 - toastWidth/2,
                                  y: SizeLiterals.Screen.screenHeight - toastHeight - 136,
                                  width: toastWidth,
                                  height: toastHeight)
        self.addSubviews(toastLabel)
        
        UIView.animate(withDuration: 1.0, delay: 3.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
