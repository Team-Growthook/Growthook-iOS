//
//  MainTitleBarView.swift
//  Growthook
//
//  Created by 천성우 on 11/13/23.
//

import UIKit

import SnapKit
import Then

final class MainTitleBarView: UIView {
    
    // MARK: - UI Components
    
    private let mainTitleLabel = UILabel()
    
    // MARK: - Properties
    
    private let userName: String = "EON"
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setAddTarget()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit call MainTitleBar")
    }
}

extension MainTitleBarView {
    
    // MARK: - UI Components Property
    
    private func setUI(){
        mainTitleLabel.do {
            $0.text = "\(userName)님의 액션"
            $0.font = .fontGuide(.head1)
            $0.textColor = .white000
        }
    }
    
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        addSubviews(mainTitleLabel)
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(18)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {}
    
    // MARK: - @objc Methods
    
}
