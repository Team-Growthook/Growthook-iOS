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
import RxCocoa
import RxSwift

final class CaveDetailView: BaseView {

    // MARK: - UI Components
    
    private let navigationView = CustomNavigationBar()
    private let caveDescriptionView = UIView()
    private let insightListView = InsightListView()
    private let addSeedButton = UIButton()
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
        self.backgroundColor = .clear
        
        navigationView.do {
            $0.isBackButtonIncluded = true
            $0.isMenuButtonIncluded = true
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
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        self.addSubviews(navigationView, caveDescriptionView,
                         insightListView, addSeedButton)
        
        navigationView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 48 / 812)
        }
        
        caveDescriptionView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 188 / 812)
        }
        
        insightListView.snp.makeConstraints {
            $0.top.equalTo(caveDescriptionView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        addSeedButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
    }
}
