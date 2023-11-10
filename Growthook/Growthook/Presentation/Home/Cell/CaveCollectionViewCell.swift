//
//  CaveCollectionViewCell.swift
//  Growthook
//
//  Created by KJ on 11/10/23.
//

import UIKit

import SnapKit
import Then

final class CaveCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CaveCollectionViewCell"
    
    // MARK: - UI Components
    
    private let caveImageView = UIImageView()
    private let caveTitle = UILabel()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CaveCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .clear
        
        caveImageView.do {
            $0.image = ImageLiterals.Home.img_cave
            $0.makeCornerRound(radius: 18)
        }
        
        caveTitle.do {
            $0.text = "일곱글자까지만"
            $0.font = .fontGuide(.detail2_reg)
            $0.textColor = .white000
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(caveImageView, caveTitle)
        
        caveImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(62)
        }
        
        caveTitle.snp.makeConstraints {
            $0.top.equalTo(caveImageView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
    }
}
