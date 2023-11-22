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
    
    private let navigationBar = CustomNavigationBar()
    let confirmButton = UIButton()
    private let insightView = InsightView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
        insightView.bindInsight(model: InsightModel.dummy())
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setStyles() {
        self.backgroundColor = .gray700
        
        navigationBar.do {
            $0.isTitleViewIncluded = true
            $0.isTitleLabelIncluded = "액션 만들기"
            $0.isBackButtonIncluded = true
        }
        
        confirmButton.do {
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.gray300, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.isEnabled = false
        }
    }
    
    override func setLayout() {
        self.addSubviews(navigationBar, insightView)
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(44)
            $0.horizontalEdges.equalToSuperview()
        }
        
        insightView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
