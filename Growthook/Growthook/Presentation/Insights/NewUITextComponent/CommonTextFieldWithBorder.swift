//
//  CommonTextFieldWithBorder.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/20/23.
//

import UIKit

import RxCocoa
import RxSwift

    // MARK: - Enum For Text Edit Status
    /// 현재는 사용하고 있지 않지만, 나중에 Text Component 내부 로직에 의해 (예를 들어, 이모티콘을 사용하면 안된다.) 오류가 발생할 경우를 대비하여 추가했습니다.
enum TextComponentStatus {
    case normal
    case editing
    case error
}

    // MARK: - CommonTextComponentType 으로 3 개의 property 를 공통으로 갖습니다.
protocol CommonTextComponentType {
    var rxEditingAction: PublishRelay<UIControl.Event> { get }
    var rxStatus: PublishRelay<TextComponentStatus> { get }
    var rxTextCount: BehaviorRelay<Int> { get }
}

final class CommonTextFieldWithBorder: UITextField, CommonTextComponentType {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    private(set) var customPlaceholder: String
    private(set) var maxLength: Int
    
    /**
     UITextField 에서 발생하는 UIControl.Event 를 처리합니다. Delegate 사용을 피하기 위함입니다.
     ```
     예시)
     switch event {
     case .editingDidBegin:
     case .editingDidEnd:
     case .editingDidEndOnExit:
     }
     ```
     - Note: .editingDidEndOnExit 는 ShouldReturn 메서드와 대응됩니다.
     */
    var rxEditingAction = PublishRelay<UIControl.Event>()
    
    /**
     UITextField 의 Status 를 나타냅니다.
     ```
     - normal: 글자 수가 넘지 않았거나 정상적인 상황
     - editing: 현재 수정 중인 상황
     - error: 글자 수를 넘어선 error 상황
     ```
     */
    var rxStatus = PublishRelay<TextComponentStatus>()
    var rxTextCount = BehaviorRelay<Int>(value: 0)
    /**
     - UITextField 의 rx.changedText 를 rx.text 에 바인딩합니다.
     - Warning: rx.text 에 바인딩되므로 해당 프로퍼티를 직접 사용하지 않습니다.
     */
    private lazy var modifiedText: Driver<String?> = self.rx.changedText
        .orEmpty
        .distinctUntilChanged()
        .scan(self.text) { [weak self] (previousValue, newValue) -> String? in
            guard let self else { return previousValue }
            guard let previousValue else { return previousValue }
            
            if newValue.count > self.maxLength {
                return previousValue
            } else {
                self.rxTextCount.accept(newValue.count)
                return newValue
            }
        }
        .asDriver(onErrorJustReturn: "")
    
    // MARK: - Life cycle
    init(placeholder: String, maxLength: Int) {
        self.customPlaceholder = placeholder
        self.maxLength = maxLength
        super.init(frame: .zero)
        bindEditingAction()
        bindText()
        setStyles()
        setBorderLine()
    }
    
    // MARK: - Overriding methods to modify UI
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        let rectWidth = rect.width
        let rectHeight = rect.height
        return CGRect(x: 18, y: 0, width: rectWidth - 30, height: rectHeight)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.offsetBy(dx: -15, dy: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommonTextFieldWithBorder {
    
    // MARK: - Bind Action
    private func bindEditingAction() {
        self.rx.editingActions
            .map { $0.event }
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.rxEditingAction.accept($0)
            })
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
        self.textColor = .white000
        self.font = .fontGuide(.body3_bold)
        self.attributedPlaceholder = NSAttributedString(
            string: customPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray300, NSAttributedString.Key.font: UIFont.fontGuide(.body3_reg)]
        )
        self.clearButtonMode = .whileEditing
        self.leftViewMode = .always
        self.leftView = UIView(frame: .init(x: 0, y: 0, width: 18, height: 30))
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.returnKeyType = .done
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
}

extension CommonTextFieldWithBorder {
    
    // MARK: - Methods regarding Editing events
    func focusWhenDidBeginEditing() {
        modifyBorderLine(with: .green200)
    }
    
    func unfocusWhenDidEndEditing() {
        guard let text = self.text else { return }
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            modifyBorderLine(with: .gray200)
        } else {
            modifyBorderLine(with: .white000)
        }
    }
    
    func hideKeyboard() {
        self.resignFirstResponder()
    }
    
    // MARK: - Methods for special case
    func changeMaximumLimitIfNeeded(with newLimitCount: Int) {
        self.maxLength = newLimitCount
    }
}


