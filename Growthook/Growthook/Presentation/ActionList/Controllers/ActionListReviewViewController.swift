//
//  ActionListReviewViewController.swift
//  Growthook
//
//  Created by 천성우 on 11/27/23.
//

import UIKit

import Moya
import RxCocoa
import RxSwift
import SnapKit
import Then

final class ActionListReviewViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar()
    private let titleLabel = UILabel()
    private let scrapButton = UIButton()
    private let reviewTextView = UITextViewWithTintedWhenEdited(placeholder: "액션 플랜을 달성하며 어떤 것을 느꼈는지 작성해보세요", maxLength: 300)
    private let writtenDateLabel = UILabel()
    
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
        view.backgroundColor = .gray600
        
        navigationBar.do {
            $0.backgroundColor = .gray600
            $0.isTitleViewIncluded = true
            $0.isTitleLabelIncluded = "리뷰 조회"
            $0.isBackButtonIncluded = true
        }
        
        titleLabel.do {
            $0.font = .fontGuide(.body1_bold)
            $0.textColor = .white000
        }
        
        scrapButton.do {
            $0.setImage(ImageLiterals.Home.btn_scrap_light_off, for: .normal)
        }
        
        writtenDateLabel.do {
            $0.text = "0000.00.00"
            $0.font = .fontGuide(.detail1_reg)
            $0.textColor = .gray300
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        view.addSubviews(navigationBar, titleLabel, scrapButton, reviewTextView, writtenDateLabel)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(18)
        }
        
        scrapButton.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(18)
            $0.trailing.equalToSuperview().inset(8)
            $0.width.height.equalTo(48)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(339)
            $0.height.equalTo(170)
        }
        
        writtenDateLabel.snp.makeConstraints {
            $0.top.equalTo(reviewTextView.snp.bottom).offset(4)
            $0.trailing.equalTo(reviewTextView.snp.trailing).inset(4)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
    
}
