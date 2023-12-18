//
//  NotificationAlertView.swift
//  Growthook
//
//  Created by KJ on 11/30/23.
//

import UIKit

import SnapKit
import Then

final class NotificationAlertView: BaseView {

    // MARK: - UI Components
    
    private let lockImage = UIImageView()
    private let notificationLabel = UILabel()
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
        self.backgroundColor = .gray500
        self.makeCornerRound(radius: 15)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3 // 그림자 투명도
        self.layer.shadowOffset = CGSize(width: 3, height: 3) // 그림자 위치
        self.layer.shadowRadius = 3 // 그림자 반경
        self.layer.masksToBounds = false
        
        lockImage.do {
            $0.image = ImageLiterals.Home.notification_new
        }
        
        notificationLabel.do {
            $0.text = "잠금이 3일 이하로\n남은 씨앗이 3개 있어요!"
            $0.font = .fontGuide(.body3_reg)
            $0.textColor = .white000
            $0.numberOfLines = 2
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        self.addSubviews(lockImage, notificationLabel)
        
        lockImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(18)
        }
        
        notificationLabel.snp.makeConstraints {
            $0.top.equalTo(lockImage.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}
