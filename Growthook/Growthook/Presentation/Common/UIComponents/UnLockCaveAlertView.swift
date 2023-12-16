//
//  UnLockCaveAlertView.swift
//  Growthook
//
//  Created by KJ on 12/16/23.
//

import UIKit

import Then
import SnapKit

final class UnLockCaveAlertView: BaseView {
    
    // MARK: - UI Components
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let underLineView = UIView()
    let checkButton = UIButton()
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
        self.backgroundColor = .black000.withAlphaComponent(0.5)
        
        contentView.do {
            $0.backgroundColor = .gray400
            $0.makeCornerRound(radius: 20)
        }
        
        titleLabel.do {
            $0.text = "내 동굴에 친구를 초대해\n인사이트를 공유해요!"
            $0.font = .fontGuide(.head4)
            $0.textColor = .white000
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        
        descriptionLabel.do {
            $0.text = "해당 기능은 추후 업데이트 예정이에요:)"
            $0.font = .fontGuide(.body3_reg)
            $0.textColor = .gray100
        }
        
        underLineView.do {
            $0.backgroundColor = .gray300
        }
        
        checkButton.do {
            $0.setTitle("확인", for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.setTitleColor(.green400, for: .normal)
            $0.backgroundColor = .clear
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        self.addSubviews(contentView)
        contentView.addSubviews(titleLabel, descriptionLabel,
                                underLineView, checkButton)
        
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 301 / 812)
            $0.horizontalEdges.equalToSuperview().inset(43)
            $0.height.equalTo(211)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.equalTo(checkButton.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
