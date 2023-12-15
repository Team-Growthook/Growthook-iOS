//
//  MyPageThookBoxView.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/15/23.
//

import UIKit

enum MyThookType {
    case earned
    case spent
    
    var title: String {
        switch self {
        case .earned:
            return "수확한 쑥"
        case .spent:
            return "사용한 쑥"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .earned:
            return .green400
        case .spent:
            return .gray400
        }
    }
    
    var mainColor: UIColor {
        switch self {
        case .earned:
            return .white000
        case .spent:
            return .gray100
        }
    }
}

final class MyPageThookBoxView: BaseView {

    private let mainTitleLabel = UILabel()
    private let thookImageView = UIImageView()
    private let thookCountLabel = UILabel()
    private var type: MyThookType
    
    init(type: MyThookType) {
        self.type = type
        super.init(frame: .zero)
    }
        
    override func setStyles() {
        backgroundColor = type.backgroundColor
        makeCornerRound(radius: 12)
        
        mainTitleLabel.do {
            $0.font = .fontGuide(.body1_bold)
            $0.text = type.title
            $0.textColor = type.mainColor
            $0.textAlignment = .center
        }
        
        thookImageView.do {
            $0.image = ImageLiterals.Component.icn_seed_light.withRenderingMode(.alwaysTemplate)
            $0.tintColor = type.mainColor
            $0.contentMode = .scaleAspectFit
        }
        
        thookCountLabel.do {
            $0.font = .fontGuide(.body1_reg)
            $0.textColor = type.mainColor
        }
    }
    
    override func setLayout() {
        addSubviews(mainTitleLabel, thookImageView, thookCountLabel)
        
        mainTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(28)
        }
        
        thookImageView.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(7)
            $0.width.equalTo(24)
            $0.height.equalTo(22)
            $0.trailing.equalTo(self.snp.centerX).offset(-3)
        }
        
        thookCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(thookImageView.snp.centerY)
            $0.leading.equalTo(thookImageView.snp.trailing).offset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageThookBoxView {
    
    func setThookCount(with count: Int) {
        thookCountLabel.text = String(count)
    }
}
