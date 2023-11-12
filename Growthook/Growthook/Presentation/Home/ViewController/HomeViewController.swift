//
//  HomeViewController.swift
//  Growthook
//
//  Created by KJ on 11/5/23.
//

import UIKit

import Moya
import SnapKit
import Then
import RxCocoa
import RxSwift

final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let homeCaveView = HomeCaveView()
    private let insightListView = InsightListView()
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        bindViewModel()
    }
}

extension HomeViewController {
    
    private func bindViewModel() {
        viewModel.data
            .bind(to: homeCaveView.caveCollectionView.rx.items(
                cellIdentifier: "CaveCollectionViewCell",
                cellType: CaveCollectionViewCell.self)) { (_, element, cell) in
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
        
        viewModel.inputs.caveCollectionViewBind()
    }
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .gray700
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(homeCaveView, insightListView)
        
        homeCaveView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 173 / 812)
        }
        
        insightListView.snp.makeConstraints {
            $0.top.equalTo(homeCaveView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
