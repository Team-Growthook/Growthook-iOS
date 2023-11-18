//
//  ActionListTableViewCell.swift
//  Growthook
//
//  Created by 천성우 on 11/18/23.
//

import UIKit

import Then
import SnapKit

class ActionListTableViewCell: UITableViewCell {
    
    
    // MARK: - UI Components
    
    private let scrapButton = UIButton()
    private let actionTitleLabel = UILabel()
    private let seedButton = UIButton()
    private let completButton = UIButton()
    private let topBorder = UIView()
    private let bottomBorder = UIView()
    
    // MARK: - Property
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setStyles()
        selectedBackgroundView = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActionListTableViewCell {
    
    // MARK: - UI Components Property
    /// View 의 Style 을 set 합니다.

    private func setStyles() {
        self.backgroundColor = .gray700
        
        scrapButton.do {
            $0.setImage(ImageLiterals.Home.btn_scrap_light_off, for: .normal)
        }
        
        actionTitleLabel.do {
            $0.font = .fontGuide(.body3_bold)
            $0.textColor = .white000
            $0.numberOfLines = 2
        }
        
        seedButton.do {
            $0.setTitle("씨앗 보기", for: .normal)
            $0.setTitleColor(.white000, for: .normal)
            $0.titleLabel?.font = .fontGuide(.detail1_bold)
            $0.backgroundColor = .gray500
            $0.layer.cornerRadius = 10
        }
        
        completButton.do {
            $0.setTitle("완료하기", for: .normal)
            $0.setTitleColor(.white000, for: .normal)
            $0.titleLabel?.font = .fontGuide(.detail1_bold)
            $0.backgroundColor = .green400
            $0.layer.cornerRadius = 10
        }
        
        topBorder.do {
            $0.backgroundColor = .gray400
        }
        
        bottomBorder.do {
            $0.backgroundColor = .gray400
        }
    }
    
    // MARK: - Data Bind
    /// Data 와 UI 를 bind 합니다.

    func bindViewModel() {}
    
    
    // MARK: - Layout Helper
    /// View 의 Layout 을 set 합니다.
    func setLayout() {
        addSubviews(scrapButton, actionTitleLabel, seedButton, completButton, topBorder, bottomBorder)
        
        scrapButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(4)
        }
        
        actionTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(scrapButton.snp.trailing)
            $0.width.equalTo(306)
        }
        
        seedButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(164)
            $0.height.equalTo(40)
        }
        
        completButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(17)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(164)
            $0.height.equalTo(40)
        }
        
        topBorder.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        bottomBorder.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Configure
    
    func configure(_ model: ActionListModel) {
        switch model.scrapStatus {
        case .unScrap:
            scrapButton.setImage(ImageLiterals.Scrap.seed_light_default, for: .normal)
        case .scrap:
            scrapButton.setImage(ImageLiterals.Scrap.seed_light_active, for: .normal)
        }
        actionTitleLabel.text = model.title
    }
    

}
