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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.gray300, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.isEnabled = false
        }
    }
    
    override func setLayout() {
        self.addSubviews(topView, navigationBar, insightView)
        
        topView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        insightView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(125)
        }
    }
}

extension CreateActionView {
    
    func setFoldingAnimation() {
        UIView.animate(withDuration: 0.4, animations: { [self] in
            insightView.frame.size.height = 125
            insightView.fold()
            
        })
        
        insightView.snp.remakeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(125)
        }
    }
    
    func setShowingAnimation() {
        UIView.animate(withDuration: 0.4, animations: { [self] in
            insightView.frame.size.height = 153 + 125
            insightView.showDetail()
        
            
        })
        
        insightView.snp.remakeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(278)
        }
    }
}
