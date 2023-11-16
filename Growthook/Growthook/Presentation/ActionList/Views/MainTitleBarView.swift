//
//  MainTitleBarView.swift
//  Growthook
//
//  Created by 천성우 on 11/13/23.
//

import UIKit

import SnapKit
import Then

final class MainTitleBarView: BaseView {
    
    // MARK: - UI Components
    
    private let mainTitleLabel = UILabel()
    
    // MARK: - Properties
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components Property
    
    override func setStyles(){
        mainTitleLabel.do {
            $0.font = .fontGuide(.head1)
            $0.textColor = .white000
        }
    }
    
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        addSubviews(mainTitleLabel)
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(18)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {}
    
    func setTitleText(_ text: String) {
         mainTitleLabel.text = "\(text)님의 액션"
     }
    
    // MARK: - @objc Methods
    
}
