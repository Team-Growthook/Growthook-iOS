//
//  InsightSelectCaveTableViewCell.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/21/23.
//

import UIKit

final class InsightSelectCaveTableViewCell: UITableViewCell {

    private(set) var caveTitle: String?
    private(set) var caveId: Int?
    
    private let caveTitleLabel = UILabel()
    private let selectedDot = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyles()
        setLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = .gray400
        caveTitle = nil
        caveId = nil
        caveTitleLabel.text = nil
        caveTitleLabel.font = .fontGuide(.body1_reg)
        caveTitleLabel.textColor = .gray200
        selectedDot.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected != false {
            backgroundColor = .gray500
            caveTitleLabel.font = .fontGuide(.body1_bold)
            caveTitleLabel.textColor = .green400
            selectedDot.isHidden = false
        } else {
            backgroundColor = .gray400
            caveTitleLabel.font = .fontGuide(.body1_reg)
            caveTitleLabel.textColor = .gray200
            selectedDot.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InsightSelectCaveTableViewCell {
    
    private func setStyles() {
        backgroundColor = .gray400
        selectionStyle = .none
        
        caveTitleLabel.do {
            $0.font = .fontGuide(.body1_reg)
            $0.textColor = .gray200
        }
        
        selectedDot.do {
            $0.image = ImageLiterals.Insight.img_selected_dot
            $0.contentMode = .scaleAspectFit
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        addSubviews(selectedDot, caveTitleLabel)
        
        selectedDot.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(12)
        }
        
        caveTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(selectedDot.snp.leading).offset(-20)
        }
    }
}

extension InsightSelectCaveTableViewCell {
    
    func configure(with cave: InsightCaveModel) {
        caveId = cave.caveId
        caveTitle = cave.caveTitle
        caveTitleLabel.text = caveTitle
        caveTitleLabel.font = .fontGuide(.body1_reg)
        caveTitleLabel.textColor = .gray200
    }
}
