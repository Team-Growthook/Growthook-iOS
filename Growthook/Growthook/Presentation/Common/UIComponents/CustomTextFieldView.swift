//
//  CustomTextFieldView.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/13/23.
//

import UIKit

enum CustomTextFieldViewType {
    case caveName
    case caveDescription
    case detailActionPlan
    
    var title: (Bool, String?) {
        switch self {
        case .caveName:
            return (true, "이름")
        case .caveDescription:
            return (true, "소개")
        case .detailActionPlan:
            return (false, nil)
        }
    }
}

class CustomTextFieldView: UIView {
    var titleType: BottomCTAButtonType
    
    init(type: BottomCTAButtonType) {
        self.titleType = type
        super.init(frame: .zero)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
