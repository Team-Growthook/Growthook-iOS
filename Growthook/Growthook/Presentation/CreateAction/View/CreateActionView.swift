//
//  CreateActionView.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/22/23.
//

import UIKit

import SnapKit
import Then

final class CreateActionView: BaseView {
    
    private let topView = UIView()
    private let navigationBar = CustomNavigationBar()
    let confirmButton = UIButton()
    let insightView = InsightView()
    let createSpecificPlanView = CreateSpecificPlanView()
    
    override func setStyles() {
        self.backgroundColor = .gray700
        
        topView.do {
            $0.backgroundColor = .gray600
        }
        
        navigationBar.do {
            $0.backgroundColor = .gray600
            $0.isTitleViewIncluded = true
            $0.isTitleLabelIncluded = "액션 만들기"
            $0.isBackButtonIncluded = true
        }
        
        confirmButton.do {
            $0.setTitle("완료", for: .normal)
            $0.setTitleColor(.gray300, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.isEnabled = false
        }
    }
    
    override func setLayout() {
        self.addSubviews(topView, navigationBar, insightView, createSpecificPlanView)
        navigationBar.addSubview(confirmButton)
        
        topView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.size.equalTo(48)
        }
        
        insightView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(125)
        }
        
        createSpecificPlanView.snp.makeConstraints {
            $0.top.equalTo(insightView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension CreateActionView {
    
    func setFoldingLayout() {
        insightView.snp.remakeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(125)
        }
    }
    
    func setShowingLayout() {
        insightView.snp.remakeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(278)
        }
    }
}
