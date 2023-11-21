//
//  SplashViewController.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 11/12/23.
//

import UIKit

import Lottie

final class SplashViewController: BaseViewController {

    private let splashLottieView: LottieAnimationView = LottieAnimationView(name: "GrowthookSplashLottie", configuration: LottieConfiguration(renderingEngine: .mainThread))
    
    override func setStyles() {
        view.backgroundColor = .gray700.withAlphaComponent(0.9)
        
        splashLottieView.animationSpeed = 0.8
        splashLottieView.play { _ in
            let mainViewController = TabBarController()
            mainViewController.selectedIndex = 0
            
            guard let sceneDeleagate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
            
            sceneDeleagate.window?.rootViewController = UINavigationController(rootViewController: mainViewController)
            sceneDeleagate.window?.makeKeyAndVisible()
        }
    }
    
    override func setLayout() {
        view.addSubview(splashLottieView)
        
        splashLottieView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(200)
        }
    }
}
