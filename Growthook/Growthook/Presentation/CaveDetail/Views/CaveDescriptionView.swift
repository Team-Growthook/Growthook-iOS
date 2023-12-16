//
//  CaveDescriptionView.swift
//  Growthook
//
//  Created by KJ on 12/16/23.
//

import UIKit

import Moya
import SnapKit
import Then

final class CaveDescriptionView: BaseView {

    // MARK: - UI Components
    
    private let caveTitle = UILabel()
    private let caveDescriptionLabel = UILabel()
    private let userImageView = UIImageView()
    private let nicknameLabel = UILabel()
    private let lockButton = UIButton()
    
    override func setStyles() {
        
        self.backgroundColor = .gray600
        
        caveTitle.do {
            $0.text = "동굴이름임다"
            $0.font = .fontGuide(.head4)
            $0.textColor = .white
        }
        
        caveDescriptionLabel.do {
            $0.text = "동굴 설명자리에요:)"
            $0.font = .fontGuide(.body3_reg)
            $0.textColor = .gray100
        }
        
        userImageView.do {
            $0.image = ImageLiterals.Home.img_cave
        }
        
        nicknameLabel.do {
            $0.text = "색성한사람닉네임자리"
            $0.font = .fontGuide(.detail2_reg)
            $0.textColor = .gray200
        }
        
        lockButton.do {
            $0.setImage(ImageLiterals.CaveDetail.btn_close, for: .normal)
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        self.addSubviews(caveTitle, caveDescriptionLabel,
                         userImageView, nicknameLabel, lockButton)
        
        caveTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(18)
        }
        
        caveDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(caveTitle.snp.bottom).offset(1)
            $0.leading.equalTo(caveTitle)
        }
        
        userImageView.snp.makeConstraints {
            $0.top.equalTo(caveDescriptionLabel.snp.bottom).offset(16)
            $0.leading.equalTo(caveTitle)
            $0.size.equalTo(20)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(caveDescriptionLabel.snp.bottom).offset(19)
            $0.leading.equalTo(userImageView.snp.trailing).offset(10)
        }
        
        lockButton.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).offset(17)
            $0.leading.equalToSuperview().inset(6)
        }
    }
}
