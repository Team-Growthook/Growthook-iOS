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
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(scrapButton, titleLabel, dueTimeLabel)
        
        scrapButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(scrapButton.snp.trailing)
        }
        
        dueTimeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
        }
    }
    
    // MARK: - Methods
    
    func configureCell(_ model: InsightListModel) {
        switch model.scrapStatus {
        case .dark:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_off, for: .normal)
        case .scrapLight:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_light_on, for: .normal)
        case .light:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_light_off, for: .normal)
        case .lock:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_off, for: .normal)
        case .scrapDark:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_on, for: .normal)
        }
        titleLabel.text = model.title
        dueTimeLabel.text = model.dueTime
    }
}
