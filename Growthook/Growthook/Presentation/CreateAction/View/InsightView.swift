//
//  InsightView.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/22/23.
//

import UIKit

import SnapKit
import Then

final class InsightView: BaseView {
    
    private let nameLabel = UILabel()
    private let insightLabel = UILabel()
    private let dateLabel = UILabel()
    private let divisionLabel = UILabel()
    private let dDayLabel = UILabel()
    private let memoScrollView = UIScrollView()
    private let memoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemPink
        setStyles()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setStyles() {
        nameLabel.do {
            $0.font = .fontGuide(.detail1_bold)
            $0.backgroundColor = .green100
            $0.textColor = .green600
            $0.textAlignment = .center
            $0.makeCornerRound(radius: 4)
        }
        
        insightLabel.do {
            $0.font = .fontGuide(.body2_bold)
            $0.textColor = .white000
        }
        
        dateLabel.do {
            $0.font = .fontGuide(.detail2_bold)
            $0.textColor = .gray200
        }
        
        divisionLabel.do {
            $0.backgroundColor = .gray300
        }
        
        dDayLabel.do {
            $0.font = .fontGuide(.detail2_bold)
            $0.textColor = .red200
        }
        
        memoScrollView.do {
            $0.contentInsetAdjustmentBehavior = .never
        }
        
        memoLabel.do {
            $0.font = .fontGuide(.body3_reg)
            $0.textColor = .white000
            $0.numberOfLines = 0
        }
    }
    
    override func setLayout() {
        self.addSubviews(nameLabel, insightLabel, dateLabel, divisionLabel, dDayLabel, memoScrollView)
        memoScrollView.addSubview(memoLabel)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(18)
            $0.width.equalTo(36)
            $0.height.equalTo(22)
        }
        
        insightLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(18)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(insightLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(18)
        }
        
        divisionLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(10)
            $0.width.equalTo(2)
            $0.height.equalTo(14)
        }
        
        dDayLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.leading.equalTo(divisionLabel.snp.trailing).offset(10)
        }
        
        memoScrollView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(130)
        }
        
        memoLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 36)
        }
    }
}

extension InsightView {
    func bindInsight(model: InsightModel) {
        nameLabel.text = model.name
        insightLabel.text = model.insight
        dateLabel.text = model.date
        dDayLabel.text = model.dDay
        memoLabel.text = model.memo
        memoLabel.setLineSpacing(lineSpacing: 4)
    }
}
