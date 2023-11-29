//
//  RemoveInsightAlertViewController.swift
//  Growthook
//
//  Created by KJ on 11/29/23.
//

import UIKit

import SnapKit
import Then

final class RemoveInsightAlertViewController: BaseViewController {
    
    // MARK: - UI Components

    private let removeInsightView = RemoveInsightAlertView()

    // MARK: - UI Components Property
    
    override func setStyles() {
        
        view.backgroundColor = .clear
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        view.addSubviews(removeInsightView)
        
        removeInsightView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(173)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
}
