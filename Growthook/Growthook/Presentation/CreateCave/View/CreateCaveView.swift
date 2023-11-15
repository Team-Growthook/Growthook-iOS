//
//  CreateCaveView.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/12/23.
//

import UIKit

import SnapKit
import Then

class CreateCaveView: UIView {
    private let closeButton = CustomNavigationBar()
    private let containerView = UIView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let nameTextFieldView = CustomInputView(type: .caveName)
    let descriptionTextFieldView = CustomInputView(type: .caveDescription)
    let shareCaveView = CustomInputView(type: .share)
    let switchButton = UISwitch()
    let createCaveButton = BottomCTAButton(type: .createNewCave)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        containerView.backgroundColor = .systemPink
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateCaveView {
    private func setUI() {
        self.backgroundColor = .gray700
        
        closeButton.do {
            $0.isCloseButtonIncluded = true
        }
        
        titleLabel.do {
            $0.text = "새 동굴 파기"
            $0.font = .fontGuide(.head1)
            $0.textColor = .white000
        }
        
        descriptionLabel.do {
            $0.text = "새로운 동굴을 만들어,\n나만의 인사이트를 마음껏 담아보세요."
            $0.font = .fontGuide(.body2_reg)
            $0.textColor = .white000
            $0.numberOfLines = 2
            $0.setLineSpacing(lineSpacing: 6)
        }
        
        switchButton.do {
            $0.onTintColor = .green400
            $0.tintColor = .gray400
        }
    }
    
    private func setLayout() {
        self.addSubviews(closeButton, containerView, createCaveButton)
        containerView.addSubviews(titleLabel, descriptionLabel, nameTextFieldView, descriptionTextFieldView, shareCaveView, switchButton)
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(44)
            $0.trailing.equalToSuperview().inset(8)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(52)
            $0.horizontalEdges.equalToSuperview().inset(18)
//            $0.bottom.equalToSuperview()
            $0.height.equalTo(431)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(29)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.leading.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        nameTextFieldView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(34)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(99)
        }
        
        descriptionTextFieldView.snp.makeConstraints {
            $0.top.equalTo(nameTextFieldView.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(99)
        }
        
        shareCaveView.snp.makeConstraints {
            $0.top.equalTo(descriptionTextFieldView.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(27)
        }
        
        switchButton.snp.makeConstraints {
            $0.top.equalTo(shareCaveView.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(3)
        }
        
        if(SizeLiterals.Screen.screenHeight < 812) {
            createCaveButton.snp.makeConstraints {
                $0.top.greaterThanOrEqualTo(containerView.snp.bottom).offset(30)
                $0.bottom.lessThanOrEqualToSuperview().inset(52).priority(.high)
                $0.horizontalEdges.equalToSuperview().inset(18)
                $0.height.equalTo(SizeLiterals.Screen.screenHeight * 50 / 812)
            }
        }
        
        else {
            createCaveButton.snp.makeConstraints {
                $0.bottom.lessThanOrEqualToSuperview().inset(52).priority(.high)
                $0.horizontalEdges.equalToSuperview().inset(18)
                $0.height.equalTo(SizeLiterals.Screen.screenHeight * 50 / 812)
            }
        }
    }
    
    func setViewUp() {
        UIView.animate(withDuration: 0.4, animations: { [self] in
            containerView.frame.origin.y -= 50
            createCaveButton.frame.origin.y -= SizeLiterals.Screen.screenHeight < 812 ? 50 : 280
            setLayoutUp()
        })
    }
    
    func setViewDown() {
        UIView.animate(withDuration: 0.4, animations: { [self] in
            containerView.frame.origin.y += 50
            createCaveButton.frame.origin.y += SizeLiterals.Screen.screenHeight < 812 ? 50 : 280
            setLayoutDown()
        })
    }
    
    private func setLayoutUp() {
        containerView.snp.updateConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(2)
        }
        
        if(SizeLiterals.Screen.screenHeight < 812) {
            createCaveButton.snp.remakeConstraints {
                $0.top.greaterThanOrEqualTo(containerView.snp.bottom).offset(30)
                $0.bottom.lessThanOrEqualToSuperview().inset(52).priority(.high)
                $0.horizontalEdges.equalToSuperview().inset(18)
                $0.height.equalTo(SizeLiterals.Screen.screenHeight * 50 / 812)
            }
        }
        
        else {
            createCaveButton.snp.remakeConstraints {
                $0.bottom.lessThanOrEqualToSuperview().inset(52 + 280).priority(.high)
                $0.horizontalEdges.equalToSuperview().inset(18)
                $0.height.equalTo(SizeLiterals.Screen.screenHeight * 50 / 812)
            }
        }
    }
    
    private func setLayoutDown() {
        containerView.snp.updateConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(52)
        }
        
        if(SizeLiterals.Screen.screenHeight < 812) {
            createCaveButton.snp.remakeConstraints {
                $0.top.greaterThanOrEqualTo(containerView.snp.bottom).offset(30)
                $0.bottom.lessThanOrEqualToSuperview().inset(52).priority(.high)
                $0.horizontalEdges.equalToSuperview().inset(18)
                $0.height.equalTo(SizeLiterals.Screen.screenHeight * 50 / 812)
            }
        }
        
        else {
            createCaveButton.snp.remakeConstraints {
                $0.bottom.lessThanOrEqualToSuperview().inset(52).priority(.high)
                $0.horizontalEdges.equalToSuperview().inset(18)
                $0.height.equalTo(SizeLiterals.Screen.screenHeight * 50 / 812)
            }
        }
    }
}

extension CreateCaveView {
    @discardableResult
    override func becomeFirstResponder() -> Bool {
      super.becomeFirstResponder()
        return self.nameTextFieldView.textField.becomeFirstResponder()
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
      super.resignFirstResponder()
        return self.nameTextFieldView.textField.resignFirstResponder()
    }
}
