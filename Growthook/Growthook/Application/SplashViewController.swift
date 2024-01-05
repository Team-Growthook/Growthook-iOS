//
//  SplashViewController.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 11/12/23.
//

import UIKit

import Lottie

final class SplashViewController: BaseViewController {

    private let splashLottieView: LottieAnimationView = LottieAnimationView(name: "grothooksplash", configuration: LottieConfiguration(renderingEngine: .mainThread))
    private let splashLabel = UILabel()
    
    override func setStyles() {
        view.backgroundColor = .gray700.withAlphaComponent(0.9)
        
        splashLottieView.animationSpeed = 0.8
        splashLottieView.play { _ in
            var mainViewController: UIViewController
        
            if self.isFirstLaunch() {
                mainViewController = OnboardingSelectViewController()
            } else {
                mainViewController = TabBarController()
                (mainViewController as? TabBarController)?.selectedIndex = 0
            }
            
            guard let sceneDeleagate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
            
            sceneDeleagate.window?.rootViewController = UINavigationController(rootViewController: mainViewController)
            sceneDeleagate.window?.makeKeyAndVisible()
        }
        
        splashLabel.do {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4 
            
            let attributedText = NSAttributedString(
                string: "일상 속 영감이\n성장의 거름으로",
                attributes: [
                    .foregroundColor: UIColor.white000,
                    .font: UIFont.fontGuide(.body1_reg),
                    .paragraphStyle: paragraphStyle
                ]
            )
            
            $0.attributedText = attributedText
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
    }
    
    override func setLayout() {
        view.addSubviews(splashLabel, splashLottieView)
        
        splashLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(splashLottieView.snp.top).inset(7)
        }
        
        splashLottieView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Methods
    
    /**
     어플리케이션이 최초로 실행되었는지를 확인하는 메소드입니다
     로그인 기능이 아직 최종 구현이 되지 않았기에 아래처럼 구현 하였습니다
    */
    
    private func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBefore = UserDefaults.standard.bool(forKey: "hasBeenLaunchedBefore")
        if !hasBeenLaunchedBefore {
            UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBefore")
        }
        return !hasBeenLaunchedBefore
    }
}
