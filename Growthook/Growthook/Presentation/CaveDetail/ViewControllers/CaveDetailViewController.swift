//
//  CaveDetailViewController.swift
//  Growthook
//
//  Created by KJ on 12/16/23.
//

import UIKit

import Moya
import SnapKit
import Then
import RxCocoa
import RxSwift

final class CaveDetailViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let caveDetailView = CaveDetailView()
    
    // MARK: - Properties
    
    private let viewModel = CaveDetailViewModel()
    private let disposeBag = DisposeBag()
    
    override func bindViewModel() {
        
        viewModel.outputs.insightList
            .bind(to: caveDetailView.insightListView.insightCollectionView.rx.items(cellIdentifier: InsightListCollectionViewCell.className, cellType: InsightListCollectionViewCell.self)) { (index, model, cell) in
                cell.configureCell(model)
            }
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
        self.view.backgroundColor = .gray900
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        self.view.addSubviews(caveDetailView)
        
        caveDetailView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Methods
    
    override func setDelegates() {
        caveDetailView.insightListView.insightCollectionView.delegate = self
    }
    
    override func setRegister() {
        caveDetailView.insightListView.insightCollectionView.register(InsightListCollectionViewCell.self, forCellWithReuseIdentifier: InsightListCollectionViewCell.className)
    }
}

extension CaveDetailViewController: UICollectionViewDelegate {}
