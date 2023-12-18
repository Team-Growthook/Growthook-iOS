//
//  TextFieldBlockWithTitle.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/18/23.
//

import UIKit

final class TextFieldBlockWithTitle: BaseView {

    @objc dynamic private(set) var textCount: Int = 0
    
    private let titleLabel = UILabel()
    private let textCountLabel = UILabel()
    let textFieldBlock: UITextFieldWithTinitedWhenEdited
    
    init(placeholder: String) {
        self.textFieldBlock = UITextFieldWithTinitedWhenEdited(placeholders: placeholder)
        super.init(frame: .zero)
    }
    
    override func setStyles() {
        backgroundColor = .clear
        
        titleLabel.do {
            $0.font = .fontGuide(.body2_bold)
            $0.textColor = .white000
            $0.numberOfLines = 1
        }
        
        textCountLabel.do {
            $0.font = .fontGuide(.detail1_reg)
            $0.textColor = .gray300
            $0.textAlignment = .right
        }
    }
    
    override func setLayout() {
        addSubviews(titleLabel, textFieldBlock, textCountLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(18+4)
        }
        
        textFieldBlock.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        textCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18+4)
            $0.top.equalTo(textFieldBlock.snp.bottom).offset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
