//
//  LoginView.swift
//  Growthook
//
//  Created by 천성우 on 12/29/23.
//

import UIKit

import SnapKit
import Then

final class LoginView: BaseView {
    
    // MARK: - UI Components
    
    let mainTitleLabel = UILabel()
    let mainSubTitleLabel = UILabel()
    let growthookImage = UIImageView()
    
    // MARK: - Properties
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        mainTitleLabel.do {
            $0.text = I18N.Onboarding.loginMainTitle
            $0.numberOfLines = 2
            $0.font = .fontGuide(.body1_reg)
            $0.textColor = .white000
        }
        
        mainSubTitleLabel.do {
            $0.text = I18N.Onboarding.loginSubTitle
            $0.numberOfLines = 2
            $0.font = .fontGuide(.head4)
            $0.textColor = .white000
        }
        
        growthookImage.do {
            $0.image = ImageLiterals.Onboarding.ic_Growthook_Login
        }

    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        addSubviews(mainTitleLabel, mainSubTitleLabel, growthookImage)
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(32)
            $0.height.equalTo(48)
            $0.width.equalTo(257)
        }
        
        mainSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(32)
            $0.height.equalTo(54)
            $0.width.equalTo(293)
        }
        
        growthookImage.snp.makeConstraints {
            $0.top.equalTo(mainSubTitleLabel.snp.bottom).offset(92)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(170)
            $0.width.equalTo(169)
        }
    }
    
    // MARK: - Methods

    
    // MARK: - @objc Methods
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
