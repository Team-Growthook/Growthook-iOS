//
//  CreateCaveView.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/12/23.
//

import UIKit

import SnapKit
import Then

class CreateCaveView: UIView {
    private let closeButton = CustomNavigationBar()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()    
    private let createCaveButton = BottomCTAButton(type: .createNewCave)
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

extension CreateCaveView {
    private func setUI() {
        self.backgroundColor = .gray700
        
        closeButton.do {
            $0.isCloseButtonIncluded = true
        }
        
        titleLabel.do {
            $0.text = "새 동굴 파기"
            $0.font = .fontGuide(.head1)
            $0.textColor = .white000
        }
        
        descriptionLabel.do {
            $0.text = "새로운 동굴을 만들어,\n나만의 인사이트를 마음껏 담아보세요."
            $0.font = .fontGuide(.body2_reg)
            $0.textColor = .white000
            $0.numberOfLines = 2
            $0.setLineSpacing(lineSpacing: 6)
        }
    }
    
    private func setLayout() {
        self.addSubviews(closeButton, titleLabel, descriptionLabel, createCaveButton)
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(44)
            $0.trailing.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(52)
            $0.leading.equalToSuperview().inset(18)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.leading.equalToSuperview().inset(18)
        }
        
        createCaveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(52)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
    }
}
