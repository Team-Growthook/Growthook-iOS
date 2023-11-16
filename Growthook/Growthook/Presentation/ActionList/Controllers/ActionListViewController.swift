//
//  ActionListViewController.swift
//  Growthook
//
//  Created by 천성우 on 11/13/23.
//

import UIKit

import Moya
import SnapKit
import Then

final class ActionListViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let titleBarView = MainTitleBarView()
    private let segmentedView = ActionListSegmentedView()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

extension ActionListViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        view.backgroundColor = .gray700
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        view.addSubviews(titleBarView, segmentedView)
        
        titleBarView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        segmentedView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(titleBarView.snp.bottom).offset(18)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
