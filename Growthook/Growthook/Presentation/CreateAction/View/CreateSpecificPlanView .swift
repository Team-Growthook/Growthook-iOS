//
//  CreateSpecificPlan .swift
//  Growthook
//
//  Created by Minjoo Kim on 12/21/23.
//

import UIKit

import SnapKit
import Then

final class CreateSpecificPlanView: BaseView {
    
    let plusButton = UIButton()
    let planCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setStyles() {
        plusButton.setImage(ImageLiterals.ActionPlan.btn_plus, for: .normal)
        
        planCollectionView.do {
            $0.backgroundColor = .clear
            $0.contentInsetAdjustmentBehavior = .never
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    override func setLayout() {
        self.addSubviews(plusButton, planCollectionView)
        
        plusButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(26)
        }
        
        planCollectionView.snp.makeConstraints {
            $0.top.equalTo(plusButton.snp.bottom).offset(7)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview()
        }
    }
}
