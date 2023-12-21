//
//  CommonCustomNavigationBar.swift
//  Growthook 
//
//  Created by KYUBO A. SHIM on 12/21/23.
//

import UIKit

import RxCocoa
import RxSwift

class CommonCustomNavigationBar: BaseView {

    private let disposeBag = DisposeBag()
    
    // MARK: - Extended .rx Properties for Button Event
    lazy var rxBackButtonTapControl: ControlEvent<Void> = backButton.rx.tap
    lazy var rxDoneButtonTapControl: ControlEvent<Void> = doneButton.rx.tap
    
    // MARK: - UI Properties
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let doneButton = EnlargedAreaButton()

    // MARK: - Styles
    override func setStyles() {
        backgroundColor = .clear
        
        backButton.do {
            $0.setImage(ImageLiterals.NavigationBar.back, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.font = .fontGuide(.body1_reg)
            $0.textColor = .white000
        }
        
        doneButton.do {
            $0.setTitle("등록", for: .normal)
            $0.setTitleColor(.gray300, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.isEnabled = false
        }
    }
    
    // MARK: - Layout
    override func setLayout() {
        addSubviews(backButton, titleLabel, doneButton)
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        doneButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
    }
}

extension CommonCustomNavigationBar {
    
    // MARK: - Methods for Configuring View itself.
    func setTitle(with title: String) {
        titleLabel.text = title
    }
    
    func isButtonEnabled(_ isEnabled: Bool) {
        doneButton.isEnabled = isEnabled
    }
}
