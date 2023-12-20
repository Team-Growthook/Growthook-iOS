//
//  UITextFieldWithTinitedWhenEdited.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 11/12/23.
//

import UIKit

import SnapKit
import Then

protocol TextFieldTypeWithBorder {
    func setBorderLine()
    func modifyBorderLine(with color: UIColor)
}

final class UITextFieldWithTintedWhenEdited: UITextField {
    
    var placeholderFor: String
    
    init(placeholders: String) {
        self.placeholderFor = placeholders
        super.init(frame: .zero)
        self.delegate = self
        setBorderLine()
        setStyles()
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        let rectWidth = rect.width
        let rectHeight = rect.height
        return CGRect(x: 18, y: 0, width: rectWidth - 30, height: rectHeight)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.offsetBy(dx: -20, dy: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITextFieldWithTintedWhenEdited: TextFieldTypeWithBorder {
    
    private func setStyles() {
        self.backgroundColor = .gray900
        self.textColor = .white000
        self.font = .fontGuide(.body3_bold)
        self.attributedPlaceholder = NSAttributedString(string: placeholderFor,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray300, NSAttributedString.Key.font: UIFont.fontGuide(.body3_reg)]
        )
        self.clearButtonMode = .whileEditing
        self.leftViewMode = .always
        self.leftView = UIView(frame: .init(x: 0, y: 0, width: 18, height: 30))
        self.autocorrectionType = .no
        self.spellCheckingType = .no
    }
    
    func setBorderLine() {
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 7
        modifyBorderLine(with: .gray200)
    }
    
    func modifyBorderLine(with color: UIColor) {
        self.layer.borderColor = color.cgColor
    }
}

extension UITextFieldWithTintedWhenEdited: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        modifyBorderLine(with: .green200)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = self.text else { return }
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            modifyBorderLine(with: .gray200)
        } else {
            modifyBorderLine(with: .white000)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
}
