//
//  TextFieldBlockWithTitle.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/18/23.
//

import UIKit

import RxCocoa
import RxSwift

final class TextFieldBlockWithTitle: BaseView {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var maximumTextLimit: Int
    
    // MARK: - UI Properties
    private let titleLabel = UILabel()
    private let textCountLabel = UILabel()
    let textFieldBlock: CommonTextFieldWithBorder
    
    // MARK: - Life Cycles
    init(placeholder: String, maxLength: Int) {
        self.textFieldBlock = CommonTextFieldWithBorder(placeholder: placeholder, maxLength: maxLength)
        self.maximumTextLimit = maxLength
        super.init(frame: .zero)
    }
    
    override func bindViewModel() {
    // MARK: - Bind UI With Data
        textFieldBlock.rxTextCount
            .bind { [weak self] count in
                guard let self else { return }
                self.textCountLabel.text = "\(count)/\(self.maximumTextLimit)"
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Styles
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
    
    // MARK: - Layout
    override func setLayout() {
        addSubviews(titleLabel, textFieldBlock, textCountLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(18+4)
        }
        
        textFieldBlock.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        textCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18+4)
            $0.top.equalTo(textFieldBlock.snp.bottom).offset(6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextFieldBlockWithTitle {

    // MARK: - Methods for Configuring View itself.
    func setMainTitleLabel(with title: String) {
        titleLabel.text = title
    }
    
    func setNoTitleAndNoCount() {
        textFieldBlock.changeMaximumLimitIfNeeded(with: 200)
        titleLabel.removeFromSuperview()
        textCountLabel.removeFromSuperview()
        textFieldBlock.snp.remakeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.verticalEdges.equalToSuperview().inset(2)
        }
    }
}
