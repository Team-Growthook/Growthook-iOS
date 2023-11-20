//
//  MainTitleBarView.swift
//  Growthook
//
//  Created by 천성우 on 11/13/23.
//

import UIKit

import SnapKit
import Then

final class MainTitleBarView: BaseView {
    
    // MARK: - UI Components
    
    let mainTitleLabel = UILabel()
    let percentView = UIView()
    let leepImage = UIImageView()
    let percentLabel = UILabel()
    
    // MARK: - Properties
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components Property
    
    override func setStyles(){
        mainTitleLabel.do {
            $0.font = .fontGuide(.head1)
            $0.textColor = .white000
        }
        
        percentView.do {
            $0.backgroundColor = .green600
            $0.layer.cornerRadius = 6
        }
        
        leepImage.do {
            $0.image = ImageLiterals.Component.icn_seed_light
        }
        
        percentLabel.do {
            $0.font = .fontGuide(.detail1_bold)
            $0.textColor = .green100
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        addSubviews(mainTitleLabel, percentView)
        percentView.addSubviews(leepImage, percentLabel)
        
        leepImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(8)
            $0.width.equalTo(19)
            $0.height.equalTo(18)
        }
        
        percentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.width.equalTo(58)
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(18)
        }
        
        percentView.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(18)
            $0.width.equalTo(97)
            $0.height.equalTo(28)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {}
    
    func setTitleText(_ text: String) {
         mainTitleLabel.text = "\(text)님의 액션"
     }
    
    func setPersentText(_ text: String) {
        percentLabel.text = "\(text)% 달성!"
    }
    
    // MARK: - @objc Methods
    
}
