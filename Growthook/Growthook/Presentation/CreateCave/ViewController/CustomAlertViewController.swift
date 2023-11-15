//
//  CustomAlertViewController.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/14/23.
//

import UIKit

import SnapKit
import Then

class CustomAlertViewController: UIViewController {
    var alertTitle: String?
    var message: String?
    var addActionConfirm: AddAction?
    
    private lazy var alertView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var messageLabel = UILabel()
    private lazy var horizontalDividerView = UIView()
    private lazy var confirmButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

extension CustomAlertViewController {
    private func setUI() {
        self.view.backgroundColor = .black000.withAlphaComponent(0.6)
        
        alertView.do {
            $0.layer.cornerRadius = 16
            $0.backgroundColor = .gray400
        }
        
        titleLabel.do {
            $0.font = .fontGuide(.head4)
            $0.textColor = .white000
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.text = alertTitle
        }
        
        messageLabel.do {
            $0.font = .fontGuide(.body3_reg)
            $00.textColor = .gray100
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.text = message
        }
        
        horizontalDividerView.do {
            $0.backgroundColor = .lightGray
        }
        
        confirmButton.do {
            $0.setTitleColor(.label, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.setTitleColor(.green400, for: .normal)
            $0.setTitle(addActionConfirm?.text, for: .normal)
            $0.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        
        view.addSubview(alertView)
        alertView.addSubviews(titleLabel, messageLabel, horizontalDividerView, confirmButton)
        alertView.snp.makeConstraints {
            $0.width.equalTo(290)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(260)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(34)
        }
        
        messageLabel.snp.makeConstraints {
            $0.width.equalTo(260)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
        }
        
        horizontalDividerView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(0.5)
            $0.top.equalTo(messageLabel.snp.bottom).offset(34)
        }
        
        confirmButton.snp.makeConstraints {
            $0.width.equalTo(290)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(horizontalDividerView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
}

extension CustomAlertViewController {
    @objc func pressed() {
        addActionConfirm?.action?()
        dismiss(animated: true)
    }
}
