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
    
    // MARK: 만약, 모듈화를 진행한다면 public 을 추가해야합니다.
    /**
     UITextField 에서 .editingChanged, .valueChanged 의 상태에서 변경된 text 만을 사용합니다.
     */
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
