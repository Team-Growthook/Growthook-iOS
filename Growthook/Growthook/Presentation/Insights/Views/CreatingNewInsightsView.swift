//
//  CreatingNewInsightsView.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 11/12/23.
//

import UIKit

    // MARK: - Enum for configuring scrollView's height
enum NewInsightItems: CaseIterable {
    case newInsight
    case memo
    case cave
    case reference
    case referenceURL
    case goalPeriod
    
    var height: CGFloat {
        switch self {
        case .newInsight:
            return 123
        case .memo:
            return 151
        case .cave:
            return 80
        case .reference:
            return 103
        case .referenceURL:
            return 42
        case .goalPeriod:
            return 103
        }
    }
    
    static var totalHeight: CGFloat {
        var totalHeight: CGFloat = 0.0
        NewInsightItems.allCases.forEach {
            totalHeight += $0.height
        }
        // modifiedHeight 에서 뒤에 상수를 바꿔 scrollView 의 길이를 조절할 수 있다.
        let modifiedHeight = totalHeight + 300
        return modifiedHeight
    }
}

final class CreatingNewInsightsView: BaseView {
    
    // MARK: - UI Properties
    let insightTextView = TextViewBlockWithTitle(placeholder: "찾아낸 새로운 가치를 한 줄로 표현해주세요", maxLength: 30)
    let memoTextView = TextViewBlockWithTitle(placeholder: "찾아낸 가치에 대한 생각을 적어보세요 (선택)", maxLength: 300)
    let selectCaveView = SelectBlockWithTitle(placeholder: "어떤 동굴에 저장할까요?")
    let referenceTextField = TextFieldBlockWithTitle(placeholder: "출처의 정보를 입력해주세요", maxLength: 20)
    let referencURLTextField = TextFieldBlockWithTitle(placeholder: "참고한 url을 적어주세요 (선택)", maxLength: 200)
    let dividerLine = UIView()
    let goalPeriodSelectView = SelectBlockWithTitle(placeholder: "선택")
    let warningImageView = UIImageView()
    
    // MARK: - Styles
    override func setStyles() {
        backgroundColor = .clear
        
        insightTextView.do {
            $0.setMainTitleLabel(with: "인사이트")
        }
        
        memoTextView.do {
            $0.setMainTitleLabel(with: "메모")
        }
        
        selectCaveView.do {
            $0.setTitles(title: "동굴")
        }
        
        referenceTextField.do {
            $0.setMainTitleLabel(with: "출처")
        }
        
        referencURLTextField.do {
            $0.setNoTitleAndNoCount()
        }
        
        dividerLine.do {
            $0.backgroundColor = .gray400
        }
        
        goalPeriodSelectView.do {
            $0.setTitles(title: "목표 기간", subtitle: "씨앗을 저장할 기간을 설정해주세요.")
        }
        
        warningImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.image = ImageLiterals.Insight.img_warning_wholeText
        }
    }
    
    // MARK: - Layout
    override func setLayout() {
        addSubviews(
            insightTextView, memoTextView, selectCaveView,
            referenceTextField, referencURLTextField, dividerLine,
            goalPeriodSelectView, warningImageView
        )
        
        insightTextView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(NewInsightItems.newInsight.height)
        }
        
        memoTextView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(insightTextView.snp.bottom).offset(24)
            $0.height.equalTo(NewInsightItems.memo.height)
        }
        
        selectCaveView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(memoTextView.snp.bottom).offset(24)
            $0.height.equalTo(NewInsightItems.cave.height)
        }
        
        referenceTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(selectCaveView.snp.bottom).offset(48)
            $0.height.equalTo(NewInsightItems.reference.height)
        }
        
        referencURLTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(referenceTextField.snp.bottom).offset(4)
            $0.height.equalTo(NewInsightItems.referenceURL.height)
        }
        
        dividerLine.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.top.equalTo(referencURLTextField.snp.bottom).offset(24)
            $0.height.equalTo(1)
        }
        
        goalPeriodSelectView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(dividerLine.snp.bottom).offset(24)
            $0.height.equalTo(NewInsightItems.goalPeriod.height)
        }
        
        warningImageView.snp.makeConstraints {
            $0.top.equalTo(goalPeriodSelectView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(warningImageView.snp.width).dividedBy(4.8)
        }
    }
}
