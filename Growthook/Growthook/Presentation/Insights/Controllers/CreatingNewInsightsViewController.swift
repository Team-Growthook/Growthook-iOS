//
//  CreatingNewInsightsViewController.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 11/12/23.
//

import UIKit

import RxCocoa
import RxSwift

final class CreatingNewInsightsViewController: BaseViewController {

    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel = InsightsViewModel()
    private var previousFocusCoordinates: CGPoint = .zero
    private var currentScrollCoordinates: CGPoint = .zero
    
    // MARK: - UI Properties
    private let customNavigationView = CommonCustomNavigationBar()
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    private let creatingContentView = CreatingNewInsightsView()
    
    // MARK: - Edit Status Actions - Scroll
    override func bindViewModel() {
        creatingContentView.insightTextView.textViewBlock
            .rxEditingAction
            .observe(on: MainScheduler.asyncInstance)
            .bind { [weak self] event in
                guard let self else { return }
                switch event {
                case .editingDidBegin:
                    let point = self.creatingContentView.insightTextView.frame.origin
                    scrollToNewPoint(currentPoint: point)
                case .editingDidEnd:
                    scrollToTop()
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        creatingContentView.insightTextView.textViewBlock.rxNextButtonTapControl
            .observe(on: MainScheduler.asyncInstance)
            .bind { [weak self] in
                guard let self else { return }
                self.creatingContentView.memoTextView.textViewBlock.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
        
        creatingContentView.memoTextView.textViewBlock
            .rxEditingAction
            .observe(on: MainScheduler.asyncInstance)
            .bind { [weak self] event in
                guard let self else { return }
                switch event {
                case .editingDidBegin:
                    let point = self.creatingContentView.memoTextView.frame.origin
                    scrollToNewPoint(currentPoint: point)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        creatingContentView.memoTextView.textViewBlock
            .rxNextButtonTapControl
            .bind { [weak self] in
                guard let self else { return }
                self.creatingContentView.memoTextView.textViewBlock.resignFirstResponder()
                let component = self.creatingContentView.referenceTextField
                let point = component.frame.origin
                let height = component.frame.height
                scrollToNewPoint(currentPoint: point, height: height + 50)
            }
            .disposed(by: disposeBag)

        creatingContentView.referenceTextField.textFieldBlock
            .rxEditingAction
            .observe(on: MainScheduler.asyncInstance)
            .bind { [weak self] event in
                guard let self else { return }
                switch event {
                case .editingDidBegin:
                    let component = self.creatingContentView.referenceTextField
                    let point = component.frame.origin
                    let height = component.frame.height
                    scrollToNewPoint(currentPoint: point, height: height)
                case .editingDidEnd:
                    scrollToBottom()
                case .editingDidEndOnExit:
                    self.creatingContentView.referencURLTextField.textFieldBlock.becomeFirstResponder()
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        creatingContentView.referencURLTextField.textFieldBlock.rxEditingAction
            .observe(on: MainScheduler.asyncInstance)
            .bind { [weak self] event in
                guard let self else { return }
                switch event {
                case .editingDidBegin:
                    let component = self.creatingContentView.referencURLTextField
                    let point = component.frame.origin
                    let height = component.frame.height
                    scrollToNewPoint(currentPoint: point, height: height)
                case .editingDidEnd:
                    scrollToBottom()
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        // MARK: - Button Actions - Present
        creatingContentView.selectCaveView.rxButtonTapControl
            .bind { [weak self] in
                guard let self else { return }
                self.presentCaveViewController()
            }
            .disposed(by: disposeBag)
        
        creatingContentView.goalPeriodSelectView.rxButtonTapControl
            .bind { [weak self] in
                guard let self else { return }
                self.presentPeriodViewController()
            }
            .disposed(by: disposeBag)
        
        // MARK: - Bind UI With Data
        viewModel.outputs.selectedCave
            .bind { [weak self] cave in
                guard let self else { return }
                guard let cave else { return }
                self.creatingContentView.selectCaveView.setSelectedBlockText(with: cave.caveTitle)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.selectedPeriod
            .bind { [weak self] period in
                guard let self else { return }
                guard let period else { return }
                self.creatingContentView.goalPeriodSelectView.setSelectedBlockText(with: period.periodTitle)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Styles
    override func setStyles() {
        view.backgroundColor = .gray700
        
        customNavigationView.do {
            $0.setTitle(with: "새로운 씨앗 심기")
        }
        
        scrollView.do {
            $0.isScrollEnabled = true
            $0.showsVerticalScrollIndicator = false
            $0.delegate = self
        }
    }
    
    // MARK: - Layout
    override func setLayout() {
        view.addSubviews(customNavigationView, scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(creatingContentView)
        
        customNavigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 48 / 812)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(customNavigationView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        scrollContentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        creatingContentView.snp.makeConstraints {
            $0.horizontalEdges.verticalEdges.equalToSuperview()
            $0.height.equalTo(NewInsightItems.totalHeight)
        }
    }
}
    // MARK: - Presenting Helpers
extension CreatingNewInsightsViewController {
    
    private func presentCaveViewController() {
        let caveBottomSheetViewController = InsightSelectCaveSheetViewController(viewModel: self.viewModel)
        caveBottomSheetViewController.modalPresentationStyle = .pageSheet
        if let sheet = caveBottomSheetViewController.sheetPresentationController {
            sheet.detents = [
                .custom(resolver: { context in return 380 })
            ]
            sheet.preferredCornerRadius = 10
            sheet.prefersGrabberVisible = true
        }
        present(caveBottomSheetViewController, animated: true)
    }
    
    private func presentPeriodViewController() {
        let goalPeriodBottomSheetViewController = InsightSelectPeriodSheetViewController(viewModel: self.viewModel)
        goalPeriodBottomSheetViewController.modalPresentationStyle = .pageSheet
        if let sheet = goalPeriodBottomSheetViewController.sheetPresentationController {
            sheet.detents = [
                .custom(resolver: { context in return 320 })
            ]
            sheet.preferredCornerRadius = 10
            sheet.prefersGrabberVisible = true
        }
        present(goalPeriodBottomSheetViewController, animated: true)
    }
}

    // MARK: - Scrolling Helpers
extension CreatingNewInsightsViewController: UIScrollViewDelegate {
 
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset.pointee)
        currentScrollCoordinates = targetContentOffset.pointee
    }
    
    private func scrollToNewPoint(currentPoint: CGPoint, height: CGFloat = 0) {
        // 기존의 위치를 저장합니다.
        previousFocusCoordinates = currentPoint
        // 키보드의 위치 값을 고려해 보정하고 이동합니다.
        if currentPoint.y < 300 {
            if currentScrollCoordinates.y > 0 {
                  scrollToTop()
            } else {
                return
            }
        } else {
            let modifiedPoint = CGPoint(x: 0, y: currentPoint.y + height - 400)
            scrollView.setContentOffset(modifiedPoint, animated: true)
            currentScrollCoordinates = modifiedPoint
        }
    }
    
    private func scrollToTop() {
        scrollView.setContentOffset(.zero, animated: true)
        currentScrollCoordinates = .zero
    }
    
    private func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom + 25)
        if bottomOffset.y > 0 {
            scrollView.setContentOffset(bottomOffset, animated: true)
            currentScrollCoordinates = bottomOffset
        }
    }
}
