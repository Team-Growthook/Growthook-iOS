//
//  CustomTextFieldView.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/13/23.
//

import UIKit

import SnapKit
import Then

enum CustomTextFieldViewType {
    case caveName
    case caveDescription
    case detailActionPlan
    
    var tuple: (status: Bool, title: String?, placeholder: String) {
        switch self {
        case .caveName:
            return (true, "이름", "동굴의 이름을 알려주세요")
        case .caveDescription:
            return (true, "소개", "동굴을 간략히 소개해주세요")
        case .detailActionPlan:
            return (false, nil, "구체적인 계획을 설정해보세요")
        }
    }
}

class CustomTextFieldView: UIView {
    var type: CustomTextFieldViewType
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let lengthLabel = UILabel()
    
    init(type: CustomTextFieldViewType) {
        self.type = type
        super.init(frame: .zero)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextFieldView {
    private func setUI() {
        titleLabel.do {
            $0.text = type.tuple.title
            $0.textColor = .green400
            $0.font = .fontGuide(.head4)
        }
        
        textField.do {
            $0.font = .fontGuide(.body3_bold)
            $0.placeholder = type.tuple.placeholder
            $0.setPlaceholderColor(.gray300)
        }
        
        lengthLabel.do {
            $0.font = .fontGuide(.detail1_reg)
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel, textField, lengthLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(type.tuple.status ? 0 : 27)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(48)
        }
        
        lengthLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(4)
            $0.trailing.equalTo(textField.snp.trailing).offset(-4)
        }
    }
}
