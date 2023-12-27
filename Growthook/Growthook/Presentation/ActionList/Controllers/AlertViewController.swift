//
//  AlertViewController.swift
//  Growthook
//
//  Created by 천성우 on 11/29/23.
//


import UIKit

import Moya
import RxCocoa
import RxSwift
import SnapKit
import Then

final class AlertViewController: BaseViewController {
    
    private var viewModel = ActionListViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let alertView = UIView()
    private let mainView = UIView()
    private let growthookImage = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let separatorView = UIView()
    private let checkButton = UIButton()
    
    
    // MARK: - Properties
    
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        growthookImage.do {
            $0.image = ImageLiterals.Component.img_mugwort
        }
        
        mainView.do {
            $0.layer.cornerRadius = 15
            $0.backgroundColor = .gray400
        }
        
        titleLabel.do {
            $0.font = .fontGuide(.head4)
            $0.numberOfLines = 2
            $0.text = "성장의 보상으로\n쑥을 얻었어요!"
            $0.textColor = .white000
            $0.textAlignment = .center
        }
        
        subTitleLabel.do {
            $0.font = .fontGuide(.body3_reg)
            $0.numberOfLines = 3
            $0.text = "한 단계 쑥! 성장한 것을 축하해요\n수확한 쑥을 통해\n씨앗의 잠금을 해제해보세요:)"
            $0.textColor = .gray100
            $0.textAlignment = .center
        }
        
        separatorView.do {
            $0.backgroundColor = .gray100
        }
        
        checkButton.do {
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.green400, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        view.addSubviews(alertView)
        alertView.addSubviews(mainView, growthookImage, titleLabel, subTitleLabel, separatorView, checkButton)
        
        
        alertView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(290)
            $0.height.equalTo(291)
        }
        
        growthookImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.height.equalTo(70)
        }
        
        mainView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(243)
            $0.width.equalTo(290)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(growthookImage.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(221)
            $0.height.equalTo(54)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(183)
            $0.height.equalTo(63)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(34)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        checkButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(290)
            $0.height.equalTo(49)
        }
    }
    
    // MARK: - Methods
    
    
    
    // MARK: - @objc Methods
    
    @objc
    private func didTapCheckButton() {
        dismiss(animated: false, completion: nil)
    }
}

