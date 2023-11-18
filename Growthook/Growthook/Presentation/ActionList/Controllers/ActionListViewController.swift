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
    private let inprogressViewController = InprogressViewController()
    private let completeViewController = CompleteViewController()
    private lazy var viewControllers: [UIViewController] = [inprogressViewController, completeViewController]
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private var currentPage: UIViewController!
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setPage()
    }
    
    override func bindViewModel() {
        
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
        
        viewModel.outputs.titleText
            .drive(onNext: { [weak self] title in
                self?.titleBarView.setTitleText(title)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.selectedIndex
                .bind(onNext: { [weak self] index in
                    self?.segmentedView.updateButton(index: index)
                })
                .disposed(by: disposeBag)
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        view.backgroundColor = .gray700
        
        pageViewController.do {
            $0.didMove(toParent: self)
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        self.addChild(pageViewController)
        view.addSubviews(titleBarView, segmentedView, pageViewController.view)
        
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
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(segmentedView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 74 / 812)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        segmentedView.delegate = self
    }
    
    private func setPage() {
        if let firstViewController = viewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: false)
            currentPage = firstViewController
        }
    }
    
    // MARK: - @objc Methods
}


extension ActionListViewController: ActionListSegmentDelegate {
    func movePage(to index: Int) {
        switch index {
        case 0:
            switchPage(difference: 1)
        case 1:
            switchPage(difference: -1)
        default:
            break
        }
    }
    
    private func switchPage(difference: Int) {
        guard let page = viewControllers.firstIndex(of: currentPage) else { return }
        switch difference {
        case 1:
            pageViewController.setViewControllers([viewControllers[page + difference]], direction: .forward, animated: true)
        case -1:
            pageViewController.setViewControllers([viewControllers[page + difference]], direction: .reverse, animated: true)
        default:
            break
        }
        currentPage = viewControllers[page + difference]
    }
}
