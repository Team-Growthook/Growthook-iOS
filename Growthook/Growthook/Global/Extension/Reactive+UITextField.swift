//
//  Reactive+UITextField.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/20/23.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UITextField {
    
    var changedText: ControlProperty<String?> {
        return base.rx.controlProperty(editingEvents: [.editingChanged, .valueChanged], getter: { textField in
            textField.text
        }, setter: { textField, value in
            if textField.text != value {
                textField.text = value
            }
        })
    }
}
