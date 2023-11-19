//
//  CustomTextFieldView.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/13/23.
//

import UIKit

import SnapKit
import Then

enum CustomInputViewType {
    case caveName
    case caveDescription
    case detailActionPlan
    case share
    
    var setting: (title: String?, placeholder: String?) {
        switch self {
        case .caveName:
            return ("이름", "동굴의 이름을 알려주세요")
        case .caveDescription:
            return ("소개", "동굴을 간략히 소개해주세요")
        case .detailActionPlan:
            return (nil, "구체적인 계획을 설정해보세요")
        case .share:
            return ("공개하기", nil)
        }
    }
}

final class CustomInputView: UIView {
    var type: CustomInputViewType
    
    private let titleLabel = UILabel()
    let textField = UITextField()
    let lineView = UIView()
    let lengthLabel = UILabel()
    
    init(type: CustomInputViewType) {
        self.type = type
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomInputView {
    private func setUI() {
        titleLabel.do {
            $0.text = type.setting.title
            $0.textColor = .green400
            $0.font = .fontGuide(.head4)
            $0.isHidden = type.setting.title == nil ? true : false
        }
        
        textField.do {
            $0.font = .fontGuide(.body3_bold)
            $0.textColor = .white000
            $0.placeholder = type.setting.placeholder
            $0.setPlaceholderColor(.gray300)
            $0.returnKeyType = .done
            $0.isHidden = type.setting.placeholder == nil ? true : false
        }
        
        lineView.do {
            $0.backgroundColor = .gray300
            $0.isHidden = type.setting.placeholder == nil ? true : false
        }
        
        lengthLabel.do {
            $0.font = .fontGuide(.detail1_reg)
            $0.text = "00/00"
            $0.textColor = .gray300
            $0.isHidden = type.setting.placeholder == nil ? true : false
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel, textField, lineView, lengthLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(type.setting.title == nil ? 0 : 27)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        lengthLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(4)
            $0.trailing.equalTo(textField.snp.trailing).offset(-4)
        }
    }
}

extension CustomInputView {
    func setFocus() {
        lineView.backgroundColor = .green200
    }
    
    func setDone() {
        lineView.backgroundColor = .white000
    }
    
    func setEmpty() {
        lineView.backgroundColor = .gray300
    }
}