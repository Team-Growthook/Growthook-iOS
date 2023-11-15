//
//  AlertBuilder.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/14/23.
//

import UIKit

struct AddAction {
    var text: String?
    var action: (() -> Void)?
}

class AlertBuilder {
    private let baseViewController: UIViewController
    private let alertViewController = CustomAlertViewController()
    
    private var alertTitle: String?
    private var message: String?
    private var addActionConfirm: AddAction?
    init(viewController: UIViewController) {
        baseViewController = viewController
    }
    
    func setTitle(_ text: String) -> AlertBuilder {
        alertTitle = text
        return self
    }
    
    func setMessage(_ text: String) -> AlertBuilder {
        message = text
        return self
    }
    
    func addActionConfirm(_ text: String, action: (() -> Void)? = nil) -> AlertBuilder {
        addActionConfirm = AddAction(text: text, action: action)
        return self
    }
    @discardableResult
    func show() -> Self {
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        
        alertViewController.alertTitle = alertTitle
        alertViewController.message = message
        alertViewController.addActionConfirm = addActionConfirm
        
        baseViewController.present(alertViewController, animated: true)
        return self
    }
}
