//
//  OnboardingViewController.swift
//  Growthook
//
//  Created by 천성우 on 12/30/23.
//

import UIKit

import Moya
import RxCocoa
import RxSwift
import SnapKit
import Then


final class OnboardingViewController: UIPageViewController {
    
    private var viewModel = OnboardingViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private var pages = [UIViewController]()
    private var initialPage = 0
    private var pageControl: UIPageControl!
    private let startButton = UIButton()
    
    // MARK: - Properties
    
    
    // MARK: - Initializer
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPage()
        setStyles()
        setLayout()
        bindViewModel()
    }
    
    func bindViewModel() {
        startButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.pushToLoginViewController()
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI Components Property
    
    private func setStyles() {
        view.backgroundColor = .gray600
        
        startButton.do {
            $0.setTitle("시작하기", for: .normal)
            $0.setTitleColor(.gray300, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.backgroundColor = .gray500
            $0.layer.cornerRadius = 10
            $0.isEnabled = false
        }
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = .white000
        pageControl.pageIndicatorTintColor = .gray300
        pageControl.backgroundColor = .clear
        pageControl.addTarget(self, action: #selector(pageControlHandler), for: .valueChanged)
        
    }
    
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        view.addSubviews(startButton, pageControl)
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(339)
            $0.height.equalTo(50)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(startButton.snp.top).inset(-70)
        }
    }
    
    // MARK: - Methods
    
    private func setupPage() {
        let page1 = PageContentsViewController(imageName:  ImageLiterals.Onboarding.onboardingPage1,
                                               title: "인사이트 기록",
                                               subTitle: "내가 얻은 인사이트를 한 줄로 표현해요.", pageType: .oneLines)
        let page2 = PageContentsViewController(imageName: ImageLiterals.Onboarding.onboardingPage2,
                                               title: "보관함 아카이빙",
                                               subTitle: "인사이트를 보관할 나만의 동굴을 만들고,\n씨앗을 심어요.", pageType: .twoLines)
        let page3 = PageContentsViewController(imageName: ImageLiterals.Onboarding.onboardingPage3,
                                               title: "액션 플랜 생성",
                                               subTitle: "인사이트와 관련된 도전을 계획하고 달성해요.", pageType: .oneLines)
        let page4 = PageContentsViewController(imageName: ImageLiterals.Onboarding.onboardingPage4,
                                               title: "인사이트 잠금 해제",
                                               subTitle: "기간이 지나 잠긴 인사이트는\n액션 플랜을 달성해 얻은 '쑥'으로 잠금을 해제해요.", pageType: .twoLines)
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        
        guard !pages.isEmpty else {
            return
        }
        
        guard initialPage >= 0, initialPage < pages.count else {
            return
        }
        
        self.dataSource = self
        self.delegate = self
        self.setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
    
    private func updateStartButtonColor(forPageIndex pageIndex: Int) {
        if pageIndex == pages.count - 1 {
            startButton.backgroundColor = .green400
            startButton.setTitleColor(.white000, for: .normal)
            startButton.isEnabled = true

        } else {
            startButton.backgroundColor = .gray500
            startButton.setTitleColor(.gray300, for: .normal)
            startButton.isEnabled = false
        }
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func pushToLoginViewController() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        guard currentIndex > 0 else { return nil }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        guard currentIndex < (pages.count - 1) else { return nil }
        return pages[currentIndex + 1]
    }
}




extension OnboardingViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers,
              let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
        updateStartButtonColor(forPageIndex: currentIndex)
    }
}

extension OnboardingViewController {
    
    @objc func pageControlHandler(_ sender: UIPageControl) {
        guard let currnetViewController = viewControllers?.first,
              let currnetIndex = pages.firstIndex(of: currnetViewController) else { return }
        
        let direction: UIPageViewController.NavigationDirection = (sender.currentPage > currnetIndex) ? .forward : .reverse
        self.setViewControllers([pages[sender.currentPage]], direction: direction, animated: true)
    }
}
