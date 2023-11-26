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
    private let selectedRoundView = UIView()
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.font = .fontGuide(.body1_bold)
                titleLabel.textColor = .green400
                selectedRoundView.isHidden = false
                contentView.backgroundColor = .gray500
            } else {
                titleLabel.font = .fontGuide(.body1_reg)
                titleLabel.textColor = .gray200
                selectedRoundView.isHidden = true
                contentView.backgroundColor = .clear
            }
        }
    }
    
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
        
        selectedRoundView.do {
            $0.backgroundColor = .green400
            $0.isHidden = true
            $0.makeCornerRound(radius: self.selectedRoundView.frame.width / 2)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        contentView.addSubviews(titleLabel, selectedRoundView)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        selectedRoundView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(SizeLiterals.Screen.screenWidth * 12 / 375)
        }
    }
    
    // MARK: - Methods
    
    func configureCell(_ model: CaveProfile) {
        titleLabel.text = model.title
    }
}
