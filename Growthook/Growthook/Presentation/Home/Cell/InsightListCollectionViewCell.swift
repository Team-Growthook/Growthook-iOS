//
//  InsightListCollectionViewCell.swift
//  Growthook
//
//  Created by KJ on 11/12/23.
//

import UIKit

final class InsightListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "InsightListCollectionViewCell"
    
    // MARK: - UI Components
    
    private let scrapButton = UIButton()
    private let titleLabel = UILabel()
    private let dueTimeLabel = UILabel()
    private let lockView = UIView()
    private let lockImageView = UIImageView()
    
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

extension InsightListCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .gray400
        self.makeCornerRound(radius: 12)
        
        scrapButton.do {
            $0.setImage(ImageLiterals.Home.btn_scrap_light_off, for: .normal)
        }
        
        titleLabel.do {
            $0.text = "쑥쑥이들은 최고다."
            $0.font = .fontGuide(.body2_bold)
            $0.textColor = .white000
        }
        
        dueTimeLabel.do {
            $0.text = "00일 후 잠금"
            $0.font = .fontGuide(.detail3_reg)
            $0.textColor = .white000
        }
        
        lockView.do {
            $0.backgroundColor = .gray95
            $0.isHidden = true
        }
        
        lockImageView.do {
            $0.image = ImageLiterals.Home.icn_lock
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(scrapButton, titleLabel, dueTimeLabel, lockView)
        lockView.addSubviews(lockImageView)
        
        scrapButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(scrapButton.snp.trailing)
        }
        
        dueTimeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(titleLabel)
        }
        
        lockView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lockImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func configureCell(_ model: InsightList) {
        switch model.scrapStatus {
        case .dark:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_off, for: .normal)
            backgroundColor = .gray900
            titleLabel.textColor = .gray200
            dueTimeLabel.textColor = .gray200
        case .scrapDark:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_on, for: .normal)
            backgroundColor = .gray900
            titleLabel.textColor = .gray200
            dueTimeLabel.textColor = .gray200
        case .scrapLight:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_light_on, for: .normal)
        case .light:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_light_off, for: .normal)
        case .lock:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_off, for: .normal)
            backgroundColor = .gray900
            makeBorder(width: 0.5, color: .gray200)
            titleLabel.textColor = .gray200
            dueTimeLabel.textColor = .gray200
            lockView.isHidden = false
        }
        titleLabel.text = model.title
        dueTimeLabel.text = model.dueTime
    }
}
