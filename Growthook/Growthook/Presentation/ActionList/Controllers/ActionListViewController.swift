//
//  ActionListViewController.swift
//  Growthook
//
//  Created by 천성우 on 11/13/23.
//

import UIKit

import Moya
import RxCocoa
import RxSwift
import SnapKit
import Then

final class ActionListViewController: BaseViewController {
    
    private var viewModel = ActionListViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let titleBarView = MainTitleBarView()
    private let segmentedView = ActionListSegmentedView()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        viewModel.outputs.titleText
            .drive(onNext: { [weak self] title in
                self?.titleBarView.setTitleText(title)
            })
            .disposed(by: disposeBag)
        
        segmentedView.inProgressButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.viewModel.inputs.didTapInProgressButton()
            }
        
        segmentedView.completedButtom.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.viewModel.inputs.didTapCompletedButton()
            }
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        view.backgroundColor = .gray700
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
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

