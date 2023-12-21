//
//  CommonTextViewWithBorder.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/20/23.
//

import UIKit

import RxCocoa
import RxSwift

final class CommonTextViewWithBorder: UITextView, CommonTextComponentType {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    private var toolBarItems: [UIBarButtonItem] = []
    
    private(set) var customPlaceholder: String
    private(set) var maxLength: Int
    
    // MARK: - Extended .rx Properties
    var rxEditingAction = PublishRelay<UIControl.Event>()
    var rxStatus = PublishRelay<TextComponentStatus>()
    var rxTextCount = BehaviorRelay<Int>(value: 0)
    lazy var rxNextButtonTapControl: ControlEvent<Void> = moveToNextButton.rx.tap
    private lazy var modifiedText: Driver<String?> = self.rx.text
        .orEmpty
        .distinctUntilChanged()
        .scan(self.text) { [weak self] (previousValue, newValue) -> String? in
            guard let self else { return previousValue }
            guard let previousValue else { return previousValue }
    
            if newValue.count > self.maxLength {
                return previousValue
            } else {
                /// TextView 는 placeholder 가 없어서 placeholder 를 대체한 text 의 count 가 바로 인식되는데, 처음 화면에서 count = 0 로 만들기 위해 사용
                if newValue == customPlaceholder {
                    self.rxTextCount.accept(0)
                } else {
                    self.rxTextCount.accept(newValue.count)
                }
                return newValue
            }
        }
        .asDriver(onErrorJustReturn: "")
//    
//    // MARK: - UIBarButtonItem
//    /// TextView 에서 .resignResponder() 를 한 이후의 행동을 추가할 수 있습니다.
//    lazy var moveToNextButton: UIBarButtonItem = {
//        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 17)
//        let buttonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.right.fill", withConfiguration: symbolConfiguration), style: .plain, target: self, action: nil)
//        buttonItem.tintColor = .gray100
//        return buttonItem
//    }()
//    
    // MARK: - Life cycle
    init(placeholder: String, maxLength: Int) {
        self.customPlaceholder = placeholder
        self.maxLength = maxLength
        super.init(frame: .zero, textContainer: nil)
        bindEditingAction()
        bindText()
        setStyles()
        setBorderLine()
        setToolBarItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommonTextViewWithBorder {
    
    // MARK: - Bind Action
    private func bindEditingAction() {
        self.rx.didBeginEditing
            .bind { [weak self] in
                guard let self else { return }
                self.rxEditingAction.accept(.editingDidBegin)
                self.modifyBorderLine(with: .green200)
                if self.text == customPlaceholder {
                    self.text = nil
                    self.textColor = .white000
                    self.font = .fontGuide(.body3_bold)
                }
            }
            .disposed(by: disposeBag)
        
        self.rx.didEndEditing
            .bind { [weak self] in
                guard let self else { return }
                self.rxEditingAction.accept(.editingDidEnd)
                if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.text = customPlaceholder
                    self.textColor = .gray400
                    self.font = .fontGuide(.body3_reg)
                    modifyBorderLine(with: .gray200)
                } else {
                    modifyBorderLine(with: .white000)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func bindText() {
        modifiedText
            .drive(self.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Styles
    private func setStyles() {
        self.backgroundColor = .gray900
        self.textColor = .gray300
        self.font = .fontGuide(.body3_reg)
        self.text = customPlaceholder
        self.textContainerInset = UIEdgeInsets(top: 13, left: 8, bottom: 20, right: 16)
        self.contentInset = UIEdgeInsets(top: 0, left: 2, bottom: 5, right: 0)
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.dataDetectorTypes = .all
        self.isScrollEnabled = false
        self.verticalScrollIndicatorInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        self.isScrollEnabled = true
    }
    
    private func setBorderLine() {
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 7
        modifyBorderLine(with: .gray200)
    }
    
    private func modifyBorderLine(with color: UIColor) {
        self.layer.borderColor = color.cgColor
    }
    
    // MARK: - ToolBar Setting
    private func setToolBarItems(with items: [UIBarButtonItem] = []) {
        self.toolBarItems = items
        let toolBar = UIToolbar()

        if toolBarItems.isEmpty {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 17)
            let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let hidesKeyboardButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down", withConfiguration: symbolConfiguration), style: .plain, target: self, action: #selector(hidesKeyboardWhenTapped))
            hidesKeyboardButton.tintColor = .gray100
            toolBar.frame = CGRect(x: 0, y: 0, width: 100, height: 45)
            toolBar.setItems([
                flexibleButton,
                moveToNextButton,
                hidesKeyboardButton
            ], animated: false)
            self.inputAccessoryView = toolBar
        } else {
            toolBar.frame = CGRect(x: 0, y: 0, width: 100, height: 45)
            toolBar.setItems(self.toolBarItems, animated: false)
            self.inputAccessoryView = toolBar
        }
    }
}

extension CommonTextViewWithBorder {
    // MARK: - @objc methods
    @objc
    private func hidesKeyboardWhenTapped() {
        self.resignFirstResponder()
    }
}
