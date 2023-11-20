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

final class HomeViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let homeCaveView = HomeCaveView()
    private let insightListView = InsightListView()
    private let seedPlusButton = UIButton()
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    lazy var longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.longPressGesture.delegate = self
        insightListView.insightCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    override func bindViewModel() {
        viewModel.outputs.caveProfile
            .bind(to: homeCaveView.caveCollectionView.rx
                .items(cellIdentifier: CaveCollectionViewCell.className,
                       cellType: CaveCollectionViewCell.self)) { (index, model, cell) in
                cell.configureCell(model)
                }
                .disposed(by: disposeBag)
        
        viewModel.outputs.insightList
            .bind(to: insightListView.insightCollectionView.rx
                .items(cellIdentifier: InsightListCollectionViewCell.className,
                       cellType: InsightListCollectionViewCell.self)) { (index, model, cell) in
                cell.configureCell(model)
                }
                .disposed(by: disposeBag)
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
        view.backgroundColor = .gray700
        seedPlusButton.do {
            $0.setImage(ImageLiterals.Home.btn_add_seed, for: .normal)
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        view.addSubviews(homeCaveView, insightListView, seedPlusButton)
        
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
        
        seedPlusButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(seedPlusBottomInset() + 18)
            $0.trailing.equalToSuperview().inset(8)
        }
    }
    
    override func setDelegates() {
        homeCaveView.caveCollectionView.delegate = self
        insightListView.insightCollectionView.delegate = self
    }
    
    override func setRegister() {
        homeCaveView.caveCollectionView.register(CaveCollectionViewCell.self, forCellWithReuseIdentifier: CaveCollectionViewCell.className)
        insightListView.insightCollectionView.register(InsightListCollectionViewCell.self, forCellWithReuseIdentifier: InsightListCollectionViewCell.className)
    }
}

extension HomeViewController {
    
    // MARK: - Methods
    
    private func seedPlusBottomInset() -> CGFloat {
        if let tabBarHeight = tabBarController?.tabBar.bounds.height {
            return tabBarHeight + self.safeAreaBottomInset()
        } else {
            return 0
        }
    }
    
    // MARK: - @objc Methods
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: gesture.view)
        let collectionView = gesture.view as! UICollectionView
        if gesture.state == .began {
            // 꾹 눌림이 시작될 때 실행할 코드
            if let indexPath = insightListView.insightCollectionView.indexPathForItem(at: location) {
                viewModel.handleLongPress(at: indexPath)
                makeVibrate()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {}

extension HomeViewController: UIGestureRecognizerDelegate {}
