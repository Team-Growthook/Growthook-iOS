//
//  CreatingNewInsightsViewController.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 11/12/23.
//

import UIKit

final class CreatingNewInsightsViewController: BaseViewController {

    // Text 의 경우, StringLiterals 로 교체하기
    private let insightTextField = UITextFieldWithTinitedWhenEdited(placeholders: "찾아낸 새로운 가치를 한 줄로 표현해주세요")
    private let memoTextField = UITextViewWithTintedWhenEdited(placeholder: "찾아낸 가치에 대한 생각을 적어보세요 (생략)")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        
    }
    
    override func setStyles() {
        view.backgroundColor = .gray700
    }
    
    override func setLayout() {
        view.addSubviews(insightTextField, memoTextField)
        
        insightTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(48)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
        
        memoTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(96)
            $0.top.equalTo(insightTextField.snp.bottom).offset(40)
        }
    }
}
