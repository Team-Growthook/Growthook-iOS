//
//  CaveDetailView.swift
//  Growthook
//
//  Created by KJ on 12/16/23.
//

import UIKit

import Moya
import SnapKit
import Then

final class CaveDetailView: BaseView {

    // MARK: - UI Components
    
    private let navigationView = CustomNavigationBar()
    private let caveDescriptionView = CaveDescriptionView()
    let insightListView = InsightListView()
    private let bottomView = UIView()
    private let addSeedButton = UIButton()
    
    // 그림자를 그리는 CAGradientLayer를 생성합니다.
    let gradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bottomView.bounds
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
        self.backgroundColor = .gray600
        
        navigationView.do {
            $0.isBackButtonIncluded = true
            $0.isMenuButtonIncluded = true
            $0.isBackgroundColor = .gray600
        }
        
        insightListView.do {
            $0.makeCornerRound(radius: 10)
        }
        
        addSeedButton.do {
            $0.setTitle("씨앗 심기", for: .normal)
            $0.setTitleColor(.white000, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.backgroundColor = .green400
            $0.makeCornerRound(radius: 10)
        }
        
        gradientLayer.do {
            $0.frame = bottomView.bounds
            $0.colors = [UIColor.gray900.cgColor, UIColor.clear.cgColor]
            $0.locations = [0.0, 1.0]
            $0.startPoint = CGPoint(x: 0.7, y: 1.0)
            $0.endPoint = CGPoint(x: 0.7, y: 0.0)
        }
        
        bottomView.do {
            $0.layer.addSublayer(gradientLayer)
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        self.addSubviews(navigationView, caveDescriptionView,
                         insightListView, bottomView)
        bottomView.addSubviews(addSeedButton)
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 48 / 812)
        }
        
        caveDescriptionView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(188)
        }
        
        insightListView.snp.makeConstraints {
            $0.top.equalTo(caveDescriptionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(84)
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(138)
        }
        
        addSeedButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(54)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 50 / 812)
        }
    }
}
