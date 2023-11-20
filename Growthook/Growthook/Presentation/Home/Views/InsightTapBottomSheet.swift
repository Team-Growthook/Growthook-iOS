//
//  InsightTapBottomSheet.swift
//  Growthook
//
//  Created by KJ on 11/20/23.
//

import UIKit

import Moya
import SnapKit
import Then
import RxCocoa
import RxSwift

class InsightTapBottomSheet: BaseViewController {

    // MARK: - UI Components
    
    private let buttonView = UIView()
    private let moveButton = UIButton()
    private let deleteButton = UIButton()
    
    // MARK: - UI Components Property
    
    override func setStyles() {
        
        view.backgroundColor = .clear
        
        buttonView.do {
            $0.backgroundColor = .green400
        }
        
        moveButton.do {
            $0.setImage(ImageLiterals.Home.btn_move, for: .normal)
        }
        
        deleteButton.do {
            $0.setImage(ImageLiterals.Home.btn_delete, for: .normal)
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        
        view.addSubviews(buttonView)
        buttonView.addSubviews(moveButton, deleteButton)
        
        buttonView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 84 / 812)
        }
        
        moveButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(SizeLiterals.Screen.screenWidth * 70 / 375)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(moveButton)
            $0.trailing.equalToSuperview().inset(SizeLiterals.Screen.screenWidth * 70 / 375)
        }
    }
}
