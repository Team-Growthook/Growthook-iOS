//
//  ActionListBottomSheetViewController.swift
//  Growthook
//
//  Created by 천성우 on 11/22/23.
//

import UIKit

import Moya
import RxCocoa
import RxSwift
import SnapKit
import Then

protocol NotificationDismissBottomSheet: AnyObject {
    func notificationDismiss()
}

final class ActionListBottomSheetViewController: BaseViewController {
    
    private var viewModel = ActionListViewModel()
    private let disposeBag = DisposeBag()
    
    private let bottomSheetTitleLabel = UILabel()
    private let dismissButton = UIButton()
    private let reviewTextView = UITextViewWithTintedWhenEdited(placeholder: "액션 플랜을 달성하며 어떤 것을 느꼈는지 작성해보세요", maxLength: 300)
    private let reviewCountLabel = UILabel()
    private let saveButton = UIButton()
    private let cancelButton = UIButton()
    
    // MARK: - UI Components
    
    // MARK: - Properties
    
    weak var delegate: NotificationDismissBottomSheet?
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        cancelButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true)
                self.delegate?.notificationDismiss()
                self.viewModel.inputs.didTapCancelButtonInBottomSheet()
            }
            .disposed(by: disposeBag)
        
        reviewTextView.rx.text.orEmpty
            .bind { [weak self] value in
                self?.viewModel.inputs.setReviewText(with: value)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.isReviewEntered
            .drive(onNext: { [weak self] isEntered in
                self?.saveButton.backgroundColor = isEntered ? .green400 : .gray500
                self?.saveButton.setTitleColor(isEntered ? .white000 : .gray300, for: .normal)
                self?.saveButton.isEnabled = isEntered ? true : false
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.reviewTextCount
            .drive(reviewCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        view.backgroundColor = .gray600
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.preferredCornerRadius = 20
            sheetPresentationController.prefersGrabberVisible = false
            sheetPresentationController.detents = [.custom {context in
                return 490
            }]
        }
        
        bottomSheetTitleLabel.do {
            $0.text = "리뷰 작성하기"
            $0.font = .fontGuide(.body1_reg)
            $0.textColor = .white000
        }
        
        dismissButton.do {
            $0.setImage(ImageLiterals.NavigationBar.close, for: .normal)
            $0.addTarget(self, action: #selector(addismissButton), for: .touchUpInside)
        }
        
        reviewCountLabel.do {
            $0.text = "00/300"
            $0.font = .fontGuide(.detail1_reg)
            $0.textColor = .gray300
        }
        
        saveButton.do {
            $0.setTitle("저장하기", for: .normal)
            $0.setTitleColor(.gray300, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.backgroundColor = .gray500
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        }
        
        cancelButton.do {
            $0.setTitle("안 쓸래요", for: .normal)
            $0.setTitleColor(.gray100, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.backgroundColor = .gray600
            $0.layer.cornerRadius = 10
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        view.addSubviews(bottomSheetTitleLabel, dismissButton, reviewTextView, reviewCountLabel, saveButton, cancelButton)
        
        bottomSheetTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(21)
            $0.width.equalTo(88)
        }
        
        dismissButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().inset(23)
            $0.width.height.equalTo(48)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.top.equalTo(bottomSheetTitleLabel.snp.bottom).offset(27)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(339)
            $0.height.equalTo(170)
        }
        
        reviewCountLabel.snp.makeConstraints {
            $0.top.equalTo(reviewTextView.snp.bottom).offset(4)
            $0.trailing.equalTo(reviewTextView.snp.trailing).inset(4)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(reviewTextView.snp.bottom).offset(69)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(339)
            $0.height.equalTo(50)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(saveButton.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(339)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Methods
    
    @objc
    private func addismissButton() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func saveButtonTap() {
        self.dismiss(animated: false) {
            let customAlertVC = AlertViewController()
            customAlertVC.modalPresentationStyle = .overFullScreen
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let mainWindow = windowScene.windows.first {
                mainWindow.rootViewController?.present(customAlertVC, animated: false, completion: nil)
            }
        }
    }
    
    // MARK: - @objc Methods
}

