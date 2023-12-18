//
//  UITextViewWithTintedWhenEdited.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 11/12/23.
//

import UIKit

import SnapKit
import Then

// https://liveupdate.tistory.com/460 이거 쓰면 될듯 (크기 변환)
final class UITextViewWithTintedWhenEdited: UITextView {
    
    private var initialPlaceholder: String
    private var maxLength: Int
    private var toolBarItems: [UIBarButtonItem] = []

    /**
     Placeholder 와 최대 길이를 정합니다.
     - parameter placeholder: - TextView 에 들어갈 Placeholder 를 정합니다.
     - parameter maxLength: - TextView 의 최대 길이를 정합니다.
     */
    init(placeholder: String, maxLength: Int) {
        self.initialPlaceholder = placeholder
        self.maxLength = maxLength
        super.init(frame: .zero, textContainer: nil)
//        self.delegate = self
        setStyles()
        setBorderLine()
        setToolBarItems()
    }
    
    /**
     Placeholder 와 최대 길이를 정합니다.
     - parameter placeholder: - TextView 에 들어갈 Placeholder 를 정합니다.
     - Default 최대 길이는 100 자 입니다.
     */
    convenience init(placeholder: String) {
        self.init(placeholder: placeholder, maxLength: 100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITextViewWithTintedWhenEdited {
    
    private func setStyles() {
        self.backgroundColor = .gray900
        self.textColor = .gray400
        self.font = .fontGuide(.body3_reg)
        self.text = initialPlaceholder
        self.textContainerInset = UIEdgeInsets(top: 13, left: 14, bottom: 20, right: 16)
        self.contentInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 0)
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.dataDetectorTypes = .all
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

extension UITextViewWithTintedWhenEdited {
    
    @objc
    private func hidesKeyboardWhenTapped() {
        self.resignFirstResponder()
    }
}
    
extension UITextViewWithTintedWhenEdited: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        modifyBorderLine(with: .green200)
        if self.text == initialPlaceholder {
            self.text = nil
            self.textColor = .white000
            self.font = .fontGuide(.body3_bold)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.text = initialPlaceholder
            self.textColor = .gray400
            self.font = .fontGuide(.body3_reg)
            modifyBorderLine(with: .gray200)
        } else {
            modifyBorderLine(with: .white000)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let maxLength = self.maxLength
        if text.count > maxLength {
            text = String(text.prefix(maxLength))
        }
        
        let maxNumberOfLine = 2
        let lineBreakCharacter = "\n"
        let lines = text.components(separatedBy: lineBreakCharacter)
        var consecutiveLineBreakCount = 0
        
        for line in lines {
            if line.isEmpty {
                consecutiveLineBreakCount += 1
            } else {
                consecutiveLineBreakCount = 0
            }
            
            if consecutiveLineBreakCount > maxNumberOfLine {
                text = String(text.dropLast())
                break
            }
        }
    }
}

extension UITextViewWithTintedWhenEdited {
    
    /// TextView 에 inputAccessoryView 에 초기화하고 싶다면, items 에 UIBarButtonItem 을 넣어 초기화시키세요.
    /// - Default 는 우측에 키보드 내림 버튼만 있습니다.
    /// - parameter items : 키보드 상단에 생기는 toolBar 에 들어갈 [UIBarButtonItem] 입니다.
    func setToolBarItems(with items: [UIBarButtonItem] = []) {
        self.toolBarItems = items
        let toolBar = UIToolbar()
        
        if toolBarItems.isEmpty {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 16)
            let emptyButtonOnLeft = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let hidesKeyboardButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down", withConfiguration: symbolConfiguration), style: .plain, target: self, action: #selector(hidesKeyboardWhenTapped))
            hidesKeyboardButton.tintColor = .gray100
            toolBar.sizeToFit()
            toolBar.setItems([emptyButtonOnLeft, flexibleButton, hidesKeyboardButton], animated: false)
            self.inputAccessoryView = toolBar
        } else {
            toolBar.sizeToFit()
            toolBar.setItems(self.toolBarItems, animated: false)
            self.inputAccessoryView = toolBar
        }
    }
}
