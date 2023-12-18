//
//  ScrapOnlyButton.swift
//  Growthook
//
//  Created by KJ on 12/3/23.
//

import UIKit

final class ScrapOnlyButton: UIButton {
    
    // MARK: - Properties
    
    var buttonName: AttributedString = "스크랩만 보기"
    var buttonImage: UIImage = ImageLiterals.Home.btn_scrap
    
    // MARK: - Initializer

    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components Property
    
    func setUI() {
        buttonName.font = .fontGuide(.detail2_reg)
        
        var config = UIButton.Configuration.filled()
        config.attributedTitle = buttonName
        config.image = buttonImage
        config.imagePadding = 4
        config.baseBackgroundColor = .clear
        config.imagePlacement = NSDirectionalRectEdge.leading
        configuration = config
    }
}
