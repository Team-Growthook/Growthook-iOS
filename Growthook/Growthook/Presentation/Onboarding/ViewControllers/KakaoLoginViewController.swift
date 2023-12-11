//
//  KakaoLoginViewController.swift
//  Growthook
//
//  Created by KJ on 12/11/23.
//

import UIKit

import Then
import SnapKit
import RxSwift
import RxCocoa
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoLoginViewController: BaseViewController {

    private let loginButton = UIButton()
    private let disposeBag = DisposeBag()
    
    override func bindViewModel() {
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.kakaoLogin()
            })
            .disposed(by: disposeBag)
    }
    
    override func setStyles() {
        
        loginButton.do {
            $0.setTitle("카카오로그인", for: .normal)
            $0.backgroundColor = .yellow
            $0.setTitleColor(.black000, for: .normal)
            $0.makeCornerRound(radius: 15)
        }
    }
    
    override func setLayout() {
        
        self.view.addSubviews(loginButton)
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(100)
            $0.horizontalEdges.equalToSuperview().inset(50)
            $0.height.equalTo(100)
        }
    }
    
    /// 사용자 정보 가져오기
    private func kakaoGetUserInfo() {
        
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print(error)
            }
            
            let userName = user?.kakaoAccount?.name
            let userEmail = user?.kakaoAccount?.email
            
            let contentText =
            "user name : \(userName)\n userEmail : \(userEmail)\n"
            
            print("user - \(user)")
            
            if userEmail == nil {
                // 동의 안함
                return
            }
            
//            self.textField.text = contentText
        }
    }
    
    private func kakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("✉️ loginWithKakaoTalk() success.")

                   //let idToken = oAuthToken.idToken ?? ""
                   //let accessToken = oAuthToken.accessToken
                   
                    self.kakaoGetUserInfo()
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("✉️ loginWithKakaoAccount() success.")
                    self.kakaoGetUserInfo()
                }
            }
        }
    }
}
