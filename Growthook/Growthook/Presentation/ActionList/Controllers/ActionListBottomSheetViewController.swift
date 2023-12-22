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
    func notificationDismissInCancelButton()
    func notificationDismissInSaveButton()
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
        
        dismissButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)

        cancelButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true)
                self.delegate?.notificationDismissInCancelButton()
                self.viewModel.inputs.didTapCancelButtonInBottomSheet()
            }
            .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true)
                self.delegate?.notificationDismissInSaveButton()
                self.viewModel.inputs.didTapSaveButtonInBottomSheet()
                
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
    
    override func setDelegates() {
        reviewTextView.delegate = self
    }

    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}

extension ActionListBottomSheetViewController: UITextViewDelegate {
    
    private func modifyBorderLine(with color: UIColor) {
        reviewTextView.layer.borderColor = color.cgColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        modifyBorderLine(with: .green200)
        if reviewTextView.text == "액션 플랜을 달성하며 어떤 것을 느꼈는지 작성해보세요" {
            reviewTextView.text = nil
            reviewTextView.textColor = .white000
            reviewTextView.font = .fontGuide(.body3_bold)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if reviewTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            reviewTextView.text = "액션 플랜을 달성하며 어떤 것을 느꼈는지 작성해보세요"
            reviewTextView.textColor = .gray400
            reviewTextView.font = .fontGuide(.body3_reg)
            modifyBorderLine(with: .gray200)
        } else {
            modifyBorderLine(with: .white000)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let maxLength = 300
        if reviewTextView.text.count > maxLength {
            reviewTextView.text = String(reviewTextView.text.prefix(maxLength))
        }
        
        let maxNumberOfLine = 2
        let lineBreakCharacter = "\n"
        let lines = reviewTextView.text.components(separatedBy: lineBreakCharacter)
        var consecutiveLineBreakCount = 0
        
        for line in lines {
            if line.isEmpty {
                consecutiveLineBreakCount += 1
            } else {
                consecutiveLineBreakCount = 0
            }
            
            if consecutiveLineBreakCount > maxNumberOfLine {
                reviewTextView.text = String(reviewTextView.text.dropLast())
                break
            }
        }
    }
}



