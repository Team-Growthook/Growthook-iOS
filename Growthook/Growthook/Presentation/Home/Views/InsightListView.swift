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

final class InsightListView: BaseView {
    
    // MARK: - UI Components
    
    private let seedTitleLabel = UILabel()
    private let scrapButton = ScrapOnlyButton()
    lazy var insightCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let flowLayout = UICollectionViewFlowLayout()
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
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
            $0.itemSize = CGSize(width: (SizeLiterals.Screen.screenWidth - 36),
                                 height: 60)
            $0.minimumLineSpacing = 12
            $0.minimumInteritemSpacing = 0
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        addSubviews(seedTitleLabel, scrapButton, insightCollectionView)
        
        seedTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalToSuperview().inset(18)
        }
        
        scrapButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(44)
            $0.trailing.equalToSuperview().inset(5)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 110 / 375)
            $0.height.equalTo(44)
        }
        
        insightCollectionView.snp.makeConstraints {
            $0.top.equalTo(scrapButton.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
