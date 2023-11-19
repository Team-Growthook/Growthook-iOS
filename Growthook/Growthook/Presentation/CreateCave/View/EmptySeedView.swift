//
//  EmptySeedView.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/15/23.
//

import UIKit

import SnapKit
import Then

final class EmptySeedView: UIView {
    private let titleLabel = UILabel()
    private let scrapView = UIImageView()
    private let mugwortView = UIImageView()
    let plantSeedButton = BottomCTAButton(type: .plantSeed)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptySeedView {
    private func setUI() {
        self.backgroundColor = .gray700
        self.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        titleLabel.do {
            $0.text = "아직 심겨진 씨앗이 없어요"
            $0.font = .fontGuide(.head4)
            $0.textColor = .white000
        }
        
        scrapView.do {
            $0.image = ImageLiterals.Scrap.btn_scrap_default
        }
        
        mugwortView.do {
            $0.image = ImageLiterals.Storage.img_mugwort_empty
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel, scrapView, mugwortView, plantSeedButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.leading.equalToSuperview().inset(18)
        }
        
        scrapView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(55)
            $0.trailing.equalToSuperview().inset(18)
        }
        
        mugwortView.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(titleLabel.snp.bottom).offset(125)
            $0.center.equalToSuperview()
            $0.size.equalTo(SizeLiterals.Screen.screenWidth * 87 / 375)
        }
        
        plantSeedButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(mugwortView.snp.bottom).offset(70).priority(.high)
            $0.bottom.lessThanOrEqualToSuperview().inset(52).priority(.high)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 50 / 812)
        }
    }
}
