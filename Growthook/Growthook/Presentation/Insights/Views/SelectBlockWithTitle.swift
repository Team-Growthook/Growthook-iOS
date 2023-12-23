//
//  SelectBlockWithTitle.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/21/23.
//

import UIKit

import RxCocoa
import RxSwift

final class SelectBlockWithTitle: BaseView {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let placeholderText: String
    private var seletedCave: String? = nil {
        didSet {
            if seletedCave != nil {
                modifyBoxBorderLine(with: .white000)
                selectedCaveLabel.font = .fontGuide(.body3_bold)
                selectedCaveLabel.textColor = .white000
            } else {
                modifyBoxBorderLine(with: .gray200)
                selectedCaveLabel.font = .fontGuide(.body3_reg)
                selectedCaveLabel.textColor = .gray300
            }
        }
    }
    
    // MARK: - Extended .rx Properties for Button Event
    lazy var rxButtonTapControl: ControlEvent<Void> = buttonForArea.rx.tap
    
    // MARK: - UI Properties
    private(set) var selectBox = UIView()
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let selectedCaveLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let buttonForArea = UIButton()
    
    // MARK: - Life Cycles
    init(placeholder: String) {
        self.placeholderText = placeholder
        super.init(frame: .zero)
    }
    
    // MARK: - Styles
    override func setStyles() {
        backgroundColor = .clear
        
        selectBox.do {
            $0.backgroundColor = .gray900
            $0.layer.borderWidth = 0.5
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 7
            $0.layer.borderColor = UIColor.gray200.cgColor
        }
        
        titleStackView.do {
            $0.axis = .vertical
            $0.spacing = 6
        }
        
        titleLabel.do {
            $0.font = .fontGuide(.body2_bold)
            $0.textColor = .white000
            $0.numberOfLines = 1
        }
        
        subtitleLabel.do {
            $0.font = .fontGuide(.detail1_reg)
            $0.textColor = .white000
        }
        
        selectedCaveLabel.do {
            $0.font = .fontGuide(.body3_reg)
            $0.textColor = .gray300
            $0.text = self.placeholderText
        }
        
        arrowImageView.do {
            $0.image = ImageLiterals.Insight.btn_down
            $0.contentMode = .scaleAspectFit
        }
        
        buttonForArea.do {
            $0.backgroundColor = .clear
        }
    }
    
    // MARK: - Layout
    override func setLayout() {
        titleStackView.addArrangedSubviews(titleLabel, subtitleLabel)
        addSubviews(
            titleStackView, selectBox, arrowImageView,
            selectedCaveLabel, buttonForArea
        )
        
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(18+4)
        }
        
        selectBox.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(48)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(selectBox)
            $0.trailing.equalToSuperview().inset(4+18)
            $0.size.equalTo(48)
        }
        
        selectedCaveLabel.snp.makeConstraints {
            $0.centerY.equalTo(selectBox)
            $0.leading.equalTo(selectBox).offset(16)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-20)
        }
        
        buttonForArea.snp.makeConstraints {
            $0.edges.equalTo(selectBox)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectBlockWithTitle {
    
    // MARK: - UI Helpers
    private func modifyBoxBorderLine(with color: UIColor) {
        self.selectBox.layer.borderColor = color.cgColor
    }
}

extension SelectBlockWithTitle {
    
    // MARK: - Methods for Configuring View itself.
    func setTitles(title: String, subtitle: String? = nil) {
        if subtitle != nil {
            titleLabel.text = title
            subtitleLabel.text = subtitle
        } else {
            titleLabel.text = title
        }
    }
    
    func setSelectedBlockText(with text: String) {
        self.seletedCave = text
        selectedCaveLabel.text = seletedCave
    }
}
