//
//  UnLockAlertView.swift
//  Growthook
//
//  Created by KJ on 11/27/23.
//

import UIKit

import Then
import SnapKit

final class UnLockInsightAlertView: BaseView {
    
    // MARK: - UI Components
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let tipView = UIView()
    private let tipLael = UILabel()
    private let leftoverMugwortView = UIView()
    private let mugwortLabel = UILabel()
    private let mugwortImage = UIImageView()
    private let mugwortCount = UILabel()
    private let underLineView = UIView()
    let giveUpButton = UIButton()
    let useButton = UIButton()
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
        self.backgroundColor = .black000.withAlphaComponent(0.5)
        
        contentView.do {
            $0.backgroundColor = .gray400
            $0.makeCornerRound(radius: 20)
        }
        
        titleLabel.do {
            $0.text = "잠금 해제하기"
            $0.font = .fontGuide(.head4)
            $0.textColor = .white000
        }
        
        descriptionLabel.do {
            $0.text = "씨앗의 잠금을 해제하기 위해\n쑥 1개를 사용합니다."
            $0.font = .fontGuide(.body3_reg)
            $0.textColor = .gray100
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        
        tipView.do {
            $0.backgroundColor = .gray500
            $0.makeCornerRound(radius: 10)
        }
        
        tipLael.do {
            $0.text = "Tip. 인사이트의 액션 플랜을 만들고 이를 달성하면,\n쑥을 얻을 수 있어요!"
            $0.font = .fontGuide(.detail3_reg)
            $0.textColor = .gray200
            $0.textAlignment = .center
            $0.numberOfLines = 2
            $0.partColorChange(targetString: "Tip.", textColor: .green400)
        }
        
        leftoverMugwortView.do {
            $0.backgroundColor = .green400
            $0.makeCornerRound(radius: 14)
        }
        
        mugwortLabel.do {
            $0.text = "현재 남은 쑥"
            $0.font = .fontGuide(.detail2_bold)
            $0.textColor = .white000
        }
        
        mugwortImage.do {
            $0.image = ImageLiterals.Component.ic_thook
        }
        
        mugwortCount.do {
            $0.text = "00"
            $0.font = .fontGuide(.detail2_bold)
            $0.textColor = .white000
        }
        
        underLineView.do {
            $0.backgroundColor = .gray300
        }
        
        giveUpButton.do {
            $0.setTitle("포기하기", for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.setTitleColor(.gray200, for: .normal)
            $0.backgroundColor = .clear
        }
        
        useButton.do {
            $0.setTitle("사용하기", for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.setTitleColor(.green400, for: .normal)
            $0.backgroundColor = .clear
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        self.addSubviews(contentView)
        contentView.addSubviews(titleLabel, descriptionLabel, tipView,
                                leftoverMugwortView, underLineView,
                                giveUpButton, useButton)
        tipView.addSubviews(tipLael)
        leftoverMugwortView.addSubviews(mugwortLabel, mugwortImage, mugwortCount)
        
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 261 / 812)
            $0.horizontalEdges.equalToSuperview().inset(43)
            $0.height.equalTo(290)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        tipView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 55 / 812)
        }
        
        tipLael.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        leftoverMugwortView.snp.makeConstraints {
            $0.bottom.equalTo(underLineView.snp.bottom).offset(-SizeLiterals.Screen.screenHeight * 23 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(26)
        }
        
        mugwortLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(14)
        }
        
        mugwortImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(mugwortLabel.snp.trailing).offset(4)
            $0.size.equalTo(12)
        }
        
        mugwortCount.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(mugwortImage.snp.trailing).offset(4)
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.equalTo(giveUpButton.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        giveUpButton.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 145 / 375)
            $0.height.equalTo(50)
        }
        
        useButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 145 / 375)
            $0.height.equalTo(giveUpButton)
        }
    }
}

extension UnLockInsightAlertView {
    
    func useButtonTapped() {
        print("useButtonTapped")
    }
}
