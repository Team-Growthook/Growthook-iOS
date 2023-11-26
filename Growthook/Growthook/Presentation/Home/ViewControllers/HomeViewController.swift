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
        addGesture()
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
        
        viewModel.outputs.insightLongTap
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.makeVibrate()
                self.presentToHalfModalViewController(indexPath)
                if let cell = insightListView.insightCollectionView.cellForItem(at: indexPath) as? InsightListCollectionViewCell {
                    cell.selectedCell()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.insightBackground
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                if let cell = insightListView.insightCollectionView.cellForItem(at: indexPath) as? InsightListCollectionViewCell {
                    cell.unSelectedCell()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.reloadInsightList
            .subscribe(onNext: { [weak self] in
                print("?")
                self?.updateInsightList()
            })
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
        longPressGesture.delegate = self
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
    
    private func addGesture() {
        insightListView.insightCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    func presentToHalfModalViewController(_ indexPath: IndexPath) {
        let insightTapVC = InsightTapBottomSheet()
        insightTapVC.modalPresentationStyle = .pageSheet
        let customDetentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: customDetentIdentifier) { (_) in
            return SizeLiterals.Screen.screenHeight * 84 / 812
        }
        
        if let sheet = insightTapVC.sheetPresentationController {
            sheet.detents = [customDetent]
            sheet.preferredCornerRadius = 0
            sheet.delegate = self
            sheet.delegate = insightTapVC as? any UISheetPresentationControllerDelegate
        }
        
        insightTapVC.onDismiss = { [weak self] in
            print("Dismissed")
            self?.viewModel.inputs.dismissInsightTap(at: indexPath)
        }
        
        insightTapVC.indexPath = indexPath
        present(insightTapVC, animated: true)
    }
    
    func updateInsightList() {
        if let selectedItems = insightListView.insightCollectionView.indexPathsForSelectedItems {
            for indexPath in selectedItems {
                insightListView.insightCollectionView.deselectItem(at: indexPath, animated: false)
            }
        }
        insightListView.insightCollectionView.reloadData()
    }
    
    // MARK: - @objc Methods
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: gesture.view)
        if gesture.state == .began {
            // 꾹 눌림이 시작될 때 실행할 코드
            if let indexPath = insightListView.insightCollectionView.indexPathForItem(at: location) {
                viewModel.inputs.handleLongPress(at: indexPath)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {}

extension HomeViewController: UIGestureRecognizerDelegate {}

extension HomeViewController: UISheetPresentationControllerDelegate {}
