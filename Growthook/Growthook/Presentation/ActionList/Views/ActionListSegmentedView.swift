//
//  ActionListSegmentedView.swift
//  Growthook
//
//  Created by 천성우 on 11/13/23.
//

import UIKit

import Then
import SnapKit

class ActionListSegmentedView: BaseView {
    
    // MARK: - UI Components
    
    private lazy var inProgressButton = UIButton(frame: .zero, primaryAction: moveToInProgress())
    private lazy var completedButtom = UIButton(frame: .zero, primaryAction: moveToCompleted())
    private let backLineView = UIView()
    private let segmentedLineView = UIView()
    
    // MARK: - Properties
    
    private var selectedIndex: Int = 0
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Components Property
    
    override func setStyles(){
        inProgressButton.do {
            $0.setTitle("진행중", for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.setTitleColor(selectedIndex == 0 ? .green400 : .gray400, for: .normal)
        }
        
        completedButtom.do {
            $0.setTitle("완료", for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.setTitleColor(selectedIndex == 0 ? .gray400 : .green400, for: .normal)
        }
        
        backLineView.do {
            $0.backgroundColor = .gray400
        }
        
        segmentedLineView.do {
            $0.backgroundColor = .green400
        }
    }
    
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        self.addSubviews(inProgressButton, completedButtom, backLineView, segmentedLineView)
        
        inProgressButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        completedButtom.snp.makeConstraints {
            $0.leading.equalTo(inProgressButton.snp.trailing)
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        backLineView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview().inset(0.5)
        }
        
        segmentedLineView.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(inProgressButton.snp.leading).inset(1)
        }
        
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {}
    
    private func updateButton(index: Int) {
        switch index {
        case 0:
            inProgressButton.setTitleColor(.gray400, for: .normal)
            completedButtom.setTitleColor(.green400, for: .normal)
        case 1:
            inProgressButton.setTitleColor(.green400, for: .normal)
            completedButtom.setTitleColor(.gray400, for: .normal)
        default:
            break
        }
    }
    
    private func moveToCompleted() -> UIAction? {
        let action = UIAction(handler: { [weak self] _ in
            guard let index = self?.selectedIndex else { return }
            
            if index == 1 {
                return
            }
            
            self?.updateButton(index: index)
            self?.moveBarAction(index: index)
        })
        return action
    }
    
    private func moveToInProgress() -> UIAction? {
        let action = UIAction(handler: { [weak self] _ in
            guard let index = self?.selectedIndex else { return }
            
            if index == 0 {
                return
            }
            
            self?.updateButton(index: index)
            self?.moveBarAction(index: index)
        })
        return action
    }
    
    private func moveBarAction(index: Int) {
        switch index {
        case 0:
            segmentedLineView.snp.remakeConstraints {
                $0.width.equalToSuperview().dividedBy(2)
                $0.height.equalTo(2)
                $0.bottom.equalToSuperview()
                $0.leading.equalTo(completedButtom.snp.leading).inset(1)
            }
            
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
            
            selectedIndex = 1
        case 1:
            segmentedLineView.snp.remakeConstraints {
                $0.width.equalToSuperview().dividedBy(2)
                $0.height.equalTo(2)
                $0.bottom.equalToSuperview()
                $0.leading.equalTo(inProgressButton.snp.leading).inset(1)
            }
            
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
            
            selectedIndex = 0
        default:
            break
        }
    }
    
    // MARK: - @objc Methods
    
}
