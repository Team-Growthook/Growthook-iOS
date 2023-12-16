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
    private let unLockAlertView = UnLockAlertView()
    lazy var longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
    
    // MARK: - Properties
    
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    private var insightDummyData = InsightList.insightListDummyData()
    
    override func bindViewModel() {
        
        viewModel.outputs.insightList
            .bind(to: caveDetailView.insightListView.insightCollectionView.rx.items(cellIdentifier: InsightListCollectionViewCell.className, cellType: InsightListCollectionViewCell.self)) { (index, model, cell) in
                cell.configureCell(model)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.insightLongTap
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.caveDetailView.addSeedButton.isHidden = true
                self.makeVibrate()
                self.presentToHalfModalViewController(indexPath)
                if let cell = caveDetailView.insightListView.insightCollectionView.cellForItem(at: indexPath) as? InsightListCollectionViewCell {
                    cell.selectedCell()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.insightBackground
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.caveDetailView.addSeedButton.isHidden = false
                if let cell = caveDetailView.insightListView.insightCollectionView.cellForItem(at: indexPath) as? InsightListCollectionViewCell {
                    cell.unSelectedCell()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.pushToInsightDetail
            .subscribe(onNext: { [weak self] indexPath in
                self?.pushToInsightDetail(at: indexPath )
            })
            .disposed(by: disposeBag)
        
        unLockAlertView.useButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.unLockAlertView.useButtonTapped()
            })
            .disposed(by: disposeBag)
        
        unLockAlertView.giveUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.unLockAlertView.removeFromSuperview()
            })
            .disposed(by: disposeBag)
        
        caveDetailView.insightListView.scrapButton.rx.tap
            .subscribe(onNext: { [weak self] in
                if let type = self?.caveDetailView.insightListView.scrapType {
                    self?.scrapTypeSetting(type)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        setNotification()
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
        longPressGesture.delegate = self
    }
    
    override func setRegister() {
        caveDetailView.insightListView.insightCollectionView.register(InsightListCollectionViewCell.self, forCellWithReuseIdentifier: InsightListCollectionViewCell.className)
    }
}

extension CaveDetailViewController {
    
    // MARK: - Methods
    
    private func addGesture() {
        caveDetailView.insightListView.insightCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(clearNotification), name: Notification.Name("DeSelectInsightNotification"), object: nil)
    }
    
    private func pushToInsightDetail(at indexPath: IndexPath) {
        caveDetailView.insightListView.insightCollectionView.deselectItem(at: indexPath, animated: false)
        if insightDummyData[indexPath.item].scrapStatus == .lock {
            view.addSubview(unLockAlertView)
            unLockAlertView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        } else {
            print("pushToInsightDetail")
        }
    }
    
    private func scrapTypeSetting(_ type: Bool) {
        let newType = type ? false : true
        if newType {
            caveDetailView.insightListView.scrapButton.setImage(ImageLiterals.Scrap.btn_scrap_active, for: .normal)
        } else {
            caveDetailView.insightListView.scrapButton.setImage(ImageLiterals.Scrap.btn_scrap_default, for: .normal)
        }
        caveDetailView.insightListView.scrapType = newType
    }
    
    func updateInsightList() {
        if let selectedItems = caveDetailView.insightListView.insightCollectionView.indexPathsForSelectedItems {
            for indexPath in selectedItems {
                caveDetailView.insightListView.insightCollectionView.deselectItem(at: indexPath, animated: false)
            }
        }
        caveDetailView.insightListView.insightCollectionView.reloadData()
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
    
    // MARK: - @objc Methods
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: gesture.view)
        if gesture.state == .began {
            // 꾹 눌림이 시작될 때 실행할 코드
            if let indexPath = caveDetailView.insightListView.insightCollectionView.indexPathForItem(at: location) {
                if insightDummyData[indexPath.item].scrapStatus == .lock {
                    return
                } else {
                    viewModel.inputs.handleLongPress(at: indexPath)
                }
            }
        }
    }
    
    @objc func clearNotification() {
        updateInsightList()
    }
}

extension CaveDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputs.insightCellTap(at: indexPath)
    }
}

extension CaveDetailViewController: UIGestureRecognizerDelegate {}

extension CaveDetailViewController: UISheetPresentationControllerDelegate {}
