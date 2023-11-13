//
//  BottomCTAButton.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/12/23.
//

import UIKit

import Then

enum BottomCTAButtonType {
    case select
    case createAction
    case plantSeed
    case createNewCave
    case addAction
    case done
    case save
    
    var title: String {
        switch self {
        case .select: 
            return "선택"
        case .createAction:
            return "액션 만들기"
        case .plantSeed:
            return "씨앗 심기"
        case .createNewCave:
            return "새 동굴 만들기"
        case .addAction:
            return "액션 더하기"
        case .done:
            return "완료"
        case .save:
            return "저장하기"
        }
    }
}


class BottomCTAButton: UIButton {
    var titleType: BottomCTAButtonType
    
    init(type: BottomCTAButtonType) {
        self.titleType = type
        super.init(frame: .zero)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BottomCTAButton {
    private func setUI() {
        self.do {
            $0.setTitle(titleType.title, for: .normal)
            $0.backgroundColor = .green400
            $0.titleLabel?.font = .fontGuide(.body1_bold)
            $0.setTitleColor(.white000, for: .normal)
            $0.layer.cornerRadius = 10
        }
    }
}
