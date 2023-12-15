//
//  MyPageListTableViewCell.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/15/23.
//

import UIKit

final class MyPageListTableViewCell: UITableViewCell {

    private let mainTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageListTableViewCell {
    
    private func setStyles() {
        backgroundColor = .gray600
        selectionStyle = .none
        
        mainTitleLabel.do {
            $0.font = .fontGuide(.body2_bold)
            $0.textColor = .white000
        }
    }
    
    private func setLayout() {
        addSubviews(mainTitleLabel)
        
        mainTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.centerY.equalToSuperview()
        }
    }
}

extension MyPageListTableViewCell {
    
    func configureWith(componentTitle: String) {
        mainTitleLabel.text = componentTitle
    }
    
    func setLogOutStyle() {
        mainTitleLabel.textColor = .red400
    }
}
