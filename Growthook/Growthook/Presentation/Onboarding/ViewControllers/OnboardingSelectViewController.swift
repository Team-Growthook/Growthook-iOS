//
//  OnboardingSelectViewController.swift
//  Growthook
//
//  Created by 천성우 on 1/1/24.
//

import UIKit

import Moya
import RxCocoa
import RxSwift
import SnapKit
import Then


final class OnboardingSelectViewController: BaseViewController {
    
    private let viewModel = OnboardingViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let solveButton = UIButton()
    private let forgetButton = OnboardingButtonView(title: "인사이트를\n까먹어요",
                                                    image: ImageLiterals.Onboarding.ic_forget)
    private let thinkButton  = OnboardingButtonView(title: "기록해둔 곳을\n못찾겠어요",
                                                    image: ImageLiterals.Onboarding.ic_notfound)
    private let undoButton = OnboardingButtonView(title: "기록한 인사이트를\n실천하지 못해요",
                                                  image: ImageLiterals.Onboarding.ic_dont)
    private let feelingButton = OnboardingButtonView(title: "성장을 체감하지\n못해요",
                                                     image: ImageLiterals.Onboarding.ic_sad)
    
    private let thookImageView = UIImageView()
    private let plantLabel = UILabel()
    private let seedLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
    }
    

    
    // MARK: - Properties
    
    override func bindViewModel() {
 
    }
    
    override func setStyles() {
        view.backgroundColor = .gray600
        navigationController?.isNavigationBarHidden = true

        titleLabel.do {
            $0.text = "성장이 필요한 당신은\n어떤 어려움을 겪고 있나요?"
            $0.textColor = .white000
            $0.font = .fontGuide(.head4)
            $0.numberOfLines = 2
            $0.textAlignment = .center
        }
        
        subTitleLabel.do {
            $0.text = "여러 개 선택할 수 있어요"
            $0.textColor = .gray100
            $0.font = .fontGuide(.detail1_reg)
            $0.textAlignment = .center
        }
        
        solveButton.do {
            $0.setTitle("어떻게 해결하나요?", for: .normal)
            $0.setTitleColor(.gray300, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.backgroundColor = .gray500
            $0.layer.cornerRadius = 10
            $0.isEnabled = false
        }
        
        thookImageView.do {
            $0.image = ImageLiterals.Component.ic_largethook_color
        }
        
        plantLabel.do {
            $0.text = "그저 성장의 씨앗을 심기만 하면 돼요."
            $0.textColor = .white000
            $0.font = .fontGuide(.head4)
            $0.textAlignment = .center
        }
        
        seedLabel.do {
            $0.text = "씨앗부터 심어볼까요?"
            $0.textColor = .gray100
            $0.font = .fontGuide(.detail1_reg)
            $0.textAlignment = .center
        }
    }
    
    override func setLayout() {
        view.addSubviews(titleLabel, subTitleLabel, forgetButton,
                         thinkButton, undoButton, feelingButton, solveButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(128)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        forgetButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(30)
            $0.width.equalTo(154)
            $0.height.equalTo(160)
        }
        
        thinkButton.snp.makeConstraints {
            $0.top.equalTo(forgetButton.snp.top)
            $0.trailing.equalToSuperview().inset(29)
            $0.width.equalTo(154)
            $0.height.equalTo(160)
        }
        
        undoButton.snp.makeConstraints {
            $0.top.equalTo(forgetButton.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(30)
            $0.width.equalTo(154)
            $0.height.equalTo(160)
        }
        
        feelingButton.snp.makeConstraints {
            $0.top.equalTo(undoButton.snp.top)
            $0.trailing.equalToSuperview().inset(29)
            $0.width.equalTo(154)
            $0.height.equalTo(160)
        }
        
        solveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(339)
            $0.height.equalTo(50)
        }
    }
    
    override func setDelegates() {
        forgetButton.delegate = self
        thinkButton.delegate = self
        undoButton.delegate = self
        feelingButton.delegate = self
    }
    
    private func setAddTarget() {
        solveButton.addTarget(self, action: #selector(switchView), for: .touchUpInside)
    }
    
    // MARK: - Methods

    private func updateSolveButtonState() {
        let isAnyButtonSelected = forgetButton.isSelected || thinkButton.isSelected || undoButton.isSelected || feelingButton.isSelected

        if isAnyButtonSelected {
            solveButton.backgroundColor = .green400
            solveButton.setTitleColor(.white000, for: .normal)
            solveButton.isEnabled = true
        } else {
            solveButton.backgroundColor = .gray500
            solveButton.setTitleColor(.gray300, for: .normal)
            solveButton.isEnabled = false
        }
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func switchView() {
        view.subviews.forEach { $0.removeFromSuperview() }
        


        titleLabel.do {
            $0.text = "이제 그로쑥이\n성장의 거름을 만들어 줄게요!"
        }
        
        solveButton.do {
            $0.removeTarget(self, action: #selector(switchView), for: .touchUpInside)
            $0.addTarget(self, action: #selector(pushToOnboardingViewController), for: .touchUpInside)
        }
        
        
        view.addSubviews(titleLabel, thookImageView, plantLabel, seedLabel, solveButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(128)
            $0.centerX.equalToSuperview()
        }
        
        thookImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(136)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(146)
            $0.height.equalTo(116)
        }
        
        plantLabel.snp.makeConstraints {
            $0.top.equalTo(thookImageView.snp.bottom).offset(31)
            $0.centerX.equalToSuperview()
        }
        
        seedLabel.snp.makeConstraints {
            $0.top.equalTo(plantLabel.snp.bottom).offset(138)
            $0.centerX.equalToSuperview()
        }
        
        solveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(339)
            $0.height.equalTo(50)
        }
        
    }
    
    @objc
    private func pushToOnboardingViewController() {
        let vc = OnboardingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension OnboardingSelectViewController: OnboardingButtonViewDelegate {
    func onboardingButtonTapped(_ buttonView: OnboardingButtonView) {
        updateSolveButtonState()
    }

}
