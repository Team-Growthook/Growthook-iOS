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

protocol PushToActionListReviewViewController: AnyObject {
    func didTapButtonInCompleteViewController()
}

final class ActionListViewController: BaseViewController {
    
    private var viewModel = ActionListViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let titleBarView = MainTitleBarView()
    let segmentedView = ActionListSegmentedView()
    private let inprogressViewController = InprogressViewController()
    private let completeViewController = CompleteViewController()
    private lazy var viewControllers: [UIViewController] = [inprogressViewController, completeViewController]
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private var currentPage: UIViewController!
    
    // MARK: - Properties
    
    private var actionListReviewViewController: ActionListReviewViewController?
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }
    
    override func bindViewModel() {
        segmentedView.inProgressButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.viewModel.inputs.didTapInProgressButton()
            }
            .disposed(by: disposeBag)
        
        segmentedView.completedButtom.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.viewModel.inputs.didTapCompletedButton()
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.titleText
            .drive(onNext: { [weak self] title in
                self?.titleBarView.setTitleText(title)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.titlePersent
            .drive(onNext: { [weak self] persent in
                self?.titleBarView.setPersentText(persent)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.selectedIndex
            .bind(onNext: { [weak self] index in
                self?.segmentedView.moveToPage(index: index)
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
            $0.height.equalTo(107)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        segmentedView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(51)
            $0.top.equalTo(titleBarView.snp.bottom)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(segmentedView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 74 / 812)
        }
    }
    
    // MARK: - set Delegates
    
    override func setDelegates() {
        segmentedView.delegate = self
        completeViewController.delegate = self
        inprogressViewController.delegate = self
    }
    
    // MARK: - Methods
    
    private func setPage() {
        if let firstViewController = viewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: false)
            currentPage = firstViewController
        }
    }
    
    func didTapButtonInCompleteViewController() {
        let vc = ActionListReviewViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        print("didTapButtonInCompleteViewController")
    }
    
    func openAlert() {
        let customAlertVC = AlertViewController()
        customAlertVC.modalPresentationStyle = .overFullScreen
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = windowScene.windows.first {
            mainWindow.rootViewController?.present(customAlertVC, animated: false, completion: nil)
        }
    }
    
    // MARK: - @objc Methods
    
}


extension ActionListViewController: ActionListSegmentDelegate , PushToActionListReviewViewController, NotificationActionListVC {
    
    func movePage(to index: Int) {
        switch index {
        case 0:
            switchPage(difference: 1)
        case 1:
            switchPage(difference: -1)
        case 2:
            switchPage(difference: 2)
        default:
            break
        }
    }
    
    private func switchPage(difference: Int) {
        guard let page = viewControllers.firstIndex(of: currentPage) else { return }
        let targetPageIndex = page + difference
        
        guard targetPageIndex >= 0, targetPageIndex < viewControllers.count || difference == 2 else {
            return
        }
        switch difference {
        case 1:
            pageViewController.setViewControllers([viewControllers[page + difference]], direction: .forward, animated: true)
        case -1:
            pageViewController.setViewControllers([viewControllers[page + difference]], direction: .reverse, animated: true)
        case 2:
            pageViewController.setViewControllers([viewControllers[page + 1]], direction: .forward, animated: true)
            currentPage = viewControllers[page + 1]
            return
        default:
            break
        }
        currentPage = viewControllers[page + difference]
    }
    
    func moveToCompletePageByCancelButton() {
        viewModel.inputs.didTapCancelButtonInBottomSheet()
    }
    
    func moveToCompletePageBySaveButton() {
        openAlert()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.inputs.didTapSaveButtonInBottomSheet()
        }
    }
    
}
