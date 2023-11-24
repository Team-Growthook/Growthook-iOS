//
//  InsightTapBottomSheet.swift
//  Growthook
//
//  Created by KJ on 11/20/23.
//

import UIKit

import Moya
import SnapKit
import Then
import RxCocoa
import RxSwift

final class InsightTapBottomSheet: BaseViewController {

    // MARK: - UI Components
    
    private let buttonView = UIView()
    private let moveButton = UIButton()
    private let deleteButton = UIButton()
    
    // MARK: - Properties
    
    private let viewModel = InsightTapViewModel()
    private let disposeBag = DisposeBag()
    var onDismiss: (() -> Void)?
    
    override func bindViewModel() {
        moveButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.inputs.moveButtonTap()
            }
            .disposed(by: disposeBag)
        viewModel.outputs.presentToCaveList
            .subscribe(onNext: { [weak self] in
                self?.presentToCaveListVC()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
        view.backgroundColor = .clear
        
        buttonView.do {
            $0.backgroundColor = .green400
        }
        
        moveButton.do {
            $0.setImage(ImageLiterals.Home.btn_move, for: .normal)
        }
        
        deleteButton.do {
            $0.setImage(ImageLiterals.Home.btn_delete, for: .normal)
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        view.addSubviews(buttonView)
        buttonView.addSubviews(moveButton, deleteButton)
        
        buttonView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 84 / 812)
        }
        
        moveButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(SizeLiterals.Screen.screenWidth * 70 / 375)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(moveButton)
            $0.trailing.equalToSuperview().inset(SizeLiterals.Screen.screenWidth * 70 / 375)
        }
    }
    
    // MARK: - Methods
    
    override func setDelegates() {
        self.presentationController?.delegate = self
    }
    
    private func presentToCaveListVC() {
        let caveListVC = CaveListHalfModal()
        caveListVC.modalPresentationStyle = .pageSheet
        let customDetentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: customDetentIdentifier) { (_) in
            return SizeLiterals.Screen.screenHeight * 420 / 812
        }
        
        if let sheet = caveListVC.sheetPresentationController {
            sheet.detents = [customDetent]
            sheet.preferredCornerRadius = 15
            sheet.prefersGrabberVisible = true
            sheet.delegate = caveListVC as? any UISheetPresentationControllerDelegate
        }
        
        present(caveListVC, animated: true)
    }
}

extension InsightTapBottomSheet: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        onDismiss?()
    }
}
