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
    private let divisionLabel = UILabel()
    let moreButton = UIButton()
    private let dateLabel = UILabel()
    private let verticalDivisionLabel = UILabel()
    private let dDayLabel = UILabel()
    private let memoScrollView = UIScrollView()
    private let memoLabel = UILabel()
    
    override func setStyles() {
        self.do {
            $0.backgroundColor = .gray600
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.bottomLeft, .bottomRight])
        }
        
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
        
        divisionLabel.do {
            $0.backgroundColor = .gray400
        }
        
        moreButton.do {
            $0.setImage(ImageLiterals.ActionPlan.btn_more, for: .normal)
        }
        
        dateLabel.do {
            $0.font = .fontGuide(.detail2_bold)
            $0.textColor = .gray200
            $0.isHidden = true
        }
        
        verticalDivisionLabel.do {
            $0.backgroundColor = .gray300
            $0.isHidden = true
        }
        
        dDayLabel.do {
            $0.font = .fontGuide(.detail2_bold)
            $0.textColor = .red200
            $0.isHidden = true
        }
        
        memoScrollView.do {
            $0.contentInsetAdjustmentBehavior = .never
        }
        
        memoLabel.do {
            $0.font = .fontGuide(.body3_reg)
            $0.textColor = .white000
            $0.numberOfLines = 0
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        self.addSubviews(nameLabel, insightLabel, divisionLabel, moreButton, dateLabel, verticalDivisionLabel, dDayLabel, memoScrollView)
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
        
        divisionLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview().inset(38)
            $0.height.equalTo(2)
        }
        
        moreButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(138)
            $0.bottom.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(insightLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(18)
        }
        
        verticalDivisionLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(10)
            $0.width.equalTo(2)
            $0.height.equalTo(14)
        }
        
        dDayLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.leading.equalTo(verticalDivisionLabel.snp.trailing).offset(10)
        }
        
        memoScrollView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(135)
        }
        
        memoLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(memoScrollView.snp.width)
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
    
    func showDetail() {
        self.dateLabel.isHidden = false
        self.verticalDivisionLabel.isHidden = false
        self.dDayLabel.isHidden = false
        self.memoLabel.isHidden = false
        self.dateLabel.alpha = 0.0
        self.verticalDivisionLabel.alpha = 0.0
        self.dDayLabel.alpha = 0.0
        self.memoLabel.alpha = 0.0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.dateLabel.alpha = 1.0
            self.verticalDivisionLabel.alpha = 1.0
            self.dDayLabel.alpha = 1.0
            self.memoLabel.alpha = 1.0
            self.divisionLabel.frame.origin.y += 153
            self.moreButton.frame.origin.y += 153
        }, completion: {(isCompleted) in
            self.moreButton.setImage(ImageLiterals.ActionPlan.btn_folding, for: .normal)
        })
    }
    
    func fold() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.dateLabel.alpha = 0.0
            self.verticalDivisionLabel.alpha = 0.0
            self.dDayLabel.alpha = 0.0
            self.memoLabel.alpha = 0.0
            self.divisionLabel.frame.origin.y -= 153
            self.moreButton.frame.origin.y -= 153
        }, completion: {(isCompleted) in
            self.moreButton.setImage(ImageLiterals.ActionPlan.btn_more, for: .normal)
            self.dateLabel.isHidden = true
            self.verticalDivisionLabel.isHidden = true
            self.dDayLabel.isHidden = true
            self.memoLabel.isHidden = true
        })
    }
}
