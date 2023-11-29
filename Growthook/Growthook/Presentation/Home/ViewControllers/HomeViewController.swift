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
    private let unLockAlertView = UnLockAlertView()
    private let notificationView = NotificationAlertView()
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    lazy var longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
    private var insightDummyData = InsightList.insightListDummyData()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        setNotification()
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
        
        viewModel.outputs.pushToInsightDetail
            .subscribe(onNext: { [weak self] indexPath in
                self?.pushToInsightDetail(at: indexPath )
            })
            .disposed(by: disposeBag)
        
        unLockAlertView.giveUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.unLockAlertView.removeFromSuperview()
            })
            .disposed(by: disposeBag)
        
        unLockAlertView.useButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.unLockAlertView.useButtonTapped()
            })
            .disposed(by: disposeBag)
        
        homeCaveView.addCaveButton.rx.tap
            .subscribe(onNext: { [weak self] in
                // addCave
            })
            .disposed(by: disposeBag)
        
        homeCaveView.notificationButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.notificationButtonTap()
            })
            .disposed(by: disposeBag)
        
        insightListView.scrapButton.rx.tap
            .subscribe(onNext: { [weak self] in
                if let type = self?.insightListView.scrapType {
                    self?.scrapTypeSetting(type)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
        view.backgroundColor = .gray700
        seedPlusButton.do {
            $0.setImage(ImageLiterals.Home.btn_add_seed, for: .normal)
        }
        
        notificationView.do {
            $0.isHidden = true
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        view.addSubviews(homeCaveView, insightListView, seedPlusButton, notificationView)
        
        homeCaveView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(173)
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
        
        notificationView.snp.makeConstraints {
            $0.top.equalTo(homeCaveView.notificationButton.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(18)
            $0.width.equalTo(168)
            $0.height.equalTo(112)
        }
    }
    
    // MARK: - Methods
    
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
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(clearNotification), name: Notification.Name("DeSelectInsightNotification"), object: nil)
    }
    
    private func pushToInsightDetail(at indexPath: IndexPath) {
        insightListView.insightCollectionView.deselectItem(at: indexPath, animated: false)
        if insightDummyData[indexPath.item].scrapStatus == .lock {
            view.addSubview(unLockAlertView)
            unLockAlertView.snp.makeConstraints {
                $0.bottom.horizontalEdges.equalToSuperview()
                $0.top.equalTo(homeCaveView.snp.bottom)
            }
        } else {
            print("pushToInsightDetail")
        }
    }
    
    private func scrapTypeSetting(_ type: Bool) {
        let newType = type ? false : true
        if newType {
            insightListView.scrapButton.setImage(ImageLiterals.Scrap.btn_scrap_active, for: .normal)
        } else {
            insightListView.scrapButton.setImage(ImageLiterals.Scrap.btn_scrap_default, for: .normal)
        }
        insightListView.scrapType = newType
    }
    
    private func notificationButtonTap() {
        notificationView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.notificationView.isHidden = true // 3초 후에 뷰를 숨김
        }

        // 배경을 터치했을 때도 숨기고자 한다면, 해당 뷰에 탭 제스처를 추가하여 구현할 수 있습니다
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideNotificationView))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    // MARK: - @objc Methods
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: gesture.view)
        if gesture.state == .began {
            // 꾹 눌림이 시작될 때 실행할 코드
            if let indexPath = insightListView.insightCollectionView.indexPathForItem(at: location) {
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
    
    @objc func hideNotificationView(_ sender: UITapGestureRecognizer) {
        notificationView.isHidden = true
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputs.insightCellTap(at: indexPath)
    }
}

extension HomeViewController: UIGestureRecognizerDelegate {}

extension HomeViewController: UISheetPresentationControllerDelegate {}
