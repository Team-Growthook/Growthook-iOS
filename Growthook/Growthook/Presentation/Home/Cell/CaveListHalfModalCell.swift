//
//  CaveListHalfModalCell.swift
//  Growthook
//
//  Created by KJ on 11/24/23.
//

import UIKit

import Then
import SnapKit

final class CaveListHalfModalCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let underLineView = UIView()
    
    // MARK: - View Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CaveListHalfModalCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .gray400
        contentView.backgroundColor = .clear
        
        titleLabel.do {
            $0.text = "동굴 이름"
            $0.textColor = .gray200
            $0.font = .fontGuide(.body1_reg)
        }
        
        underLineView.do {
            $0.backgroundColor = .gray200
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        contentView.addSubviews(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Methods
    
    func configureCell(_ model: CaveProfile) {
        titleLabel.text = model.title
    }
}
