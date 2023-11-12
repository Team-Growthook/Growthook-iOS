//
//  InsightListView.swift
//  Growthook
//
//  Created by KJ on 11/12/23.
//

import UIKit

import SnapKit
import Then
import RxCocoa
import RxSwift

final class InsightListView: UIView {
    
    // MARK: - UI Components
    
    private let seedTitleLabel = UILabel()
    private let scrapButton = ScrapOnlyButton()
    lazy var insightCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let flowLayout = UICollectionViewFlowLayout()
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        bindViewModel()
        setRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InsightListView {
    
    private func bindViewModel() {
        insightCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .clear
        
        seedTitleLabel.do {
            $0.text = "00개의 씨앗을 모았어요!"
            $0.font = .fontGuide(.head4)
            $0.textColor = .white000
        }
        
        insightCollectionView.do {
            $0.isScrollEnabled = true
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
        
        flowLayout.do {
            $0.scrollDirection = .vertical
            $0.itemSize = CGSize(width: (SizeLiterals.Screen.screenWidth * 339) / 375,
                                 height: 60)
            $0.minimumLineSpacing = 12
            $0.minimumInteritemSpacing = 0
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(seedTitleLabel, scrapButton, insightCollectionView)
        
        seedTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalToSuperview().inset(18)
        }
        
        scrapButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(44)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 110 / 375)
            $0.height.equalTo(44)
        }
        
        insightCollectionView.snp.makeConstraints {
            $0.top.equalTo(scrapButton.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setRegister() {
        insightCollectionView.register(InsightListCollectionViewCell.self, forCellWithReuseIdentifier: "InsightListCollectionViewCell")
    }
    
    // MARK: - @objc Methods
}

extension InsightListView: UICollectionViewDelegateFlowLayout {}
