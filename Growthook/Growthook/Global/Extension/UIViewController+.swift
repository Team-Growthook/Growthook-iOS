//
//  UIViewController+.swift
//  Growthook
//
//  Created by KJ on 11/4/23.
//

import UIKit

extension UIViewController {
    
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func safeAreaTopInset() -> CGFloat {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            let top = window?.safeAreaInsets.top
            return top ?? 0.0
            
        } else if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let top = window?.safeAreaInsets.top
            return top ?? 0.0
        }
    }
    
    func safeAreaBottomInset() -> CGFloat {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            let bottom = window?.safeAreaInsets.bottom
            return bottom ?? 0.0
            
        } else if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottom = window?.safeAreaInsets.bottom
            return bottom ?? 0.0
        }
    }
}
