//
//  SpecificPlanCollectionViewCell.swift
//  Growthook
//
//  Created by Minjoo Kim on 12/21/23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

protocol SendTextDelegate: AnyObject {
    func sendText(text: String)
}

final class SpecificPlanCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: SendTextDelegate?
    
    private let viewModel = CreateActionViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    let planTextView = UITextViewWithTintedWhenEdited(placeholder: "구체적인 계획을 설정해보세요", maxLength: 40)
    let countLabel = UILabel()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension SpecificPlanCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        countLabel.do {
            $0.text = "0/40"
            $0.textColor = .gray300
            $0.font = .fontGuide(.detail1_reg)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        addSubviews(planTextView, countLabel)
        
        planTextView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(68)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(planTextView.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(4)
        }
    }
    
    private func setDelegates() {
        planTextView.delegate = self
    }
//
//    private func bindViewModel() {
//        planTextView.rx.text
//            .orEmpty
//            .distinctUntilChanged()
//            .bind { [weak self] value in
//                
//                print(value)
//                guard let self else { return }
//                self.viewModel.inputs.addActionPlan(with: value)
//                print(value)
//            }
//            .disposed(by: disposeBag)
//    }
}

extension SpecificPlanCollectionViewCell: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        planTextView.modifyBorderLine(with: .green200)
        if textView.text == planTextView.initialPlaceholder {
            textView.text = nil
            textView.textColor = .white000
            textView.font = .fontGuide(.body3_bold)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = planTextView.initialPlaceholder
            textView.textColor = .gray400
            textView.font = .fontGuide(.body3_reg)
            planTextView.modifyBorderLine(with: .gray200)
        } else {
            planTextView.modifyBorderLine(with: .white000)
            guard let text = textView.text else { return }
            print(text)
            self.delegate?.sendText(text: text)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let maxLength = planTextView.maxLength
        if textView.text.count > maxLength {
            textView.text = String(textView.text.prefix(maxLength))
        }
        
        let maxNumberOfLine = 2
        let lineBreakCharacter = "\n"
        let lines = textView.text.components(separatedBy: lineBreakCharacter)
        var consecutiveLineBreakCount = 0
        
        for line in lines {
            if line.isEmpty {
                consecutiveLineBreakCount += 1
            } else {
                consecutiveLineBreakCount = 0
            }
            
            if consecutiveLineBreakCount > maxNumberOfLine {
                textView.text = String(textView.text.dropLast())
                break
            }
        }
    }
}
