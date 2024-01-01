//
//  PageContentsViewController.swift
//  Growthook
//
//  Created by 천성우 on 12/30/23.
//

import UIKit

import SnapKit
import Then

enum PageType {
    case oneLines
    case twoLines
}

class PageContentsViewController: UIViewController {
    
    private var contentView = UIView()
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var subTitleLabel = UILabel()
    
    private let pageType: PageType
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyles()
        setLayout()
    }
    
    init(imageName: UIImage, title: String, subTitle: String, pageType: PageType) {
        self.pageType = pageType
        super.init(nibName: nil, bundle: nil)
        
        imageView.image = imageName
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyles() {
        view.backgroundColor = .gray600
        navigationController?.isNavigationBarHidden = true
        
        imageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.font = .fontGuide(.head4)
            $0.textColor = .white000
        }
        
        switch pageType {
        case .oneLines:
            subTitleLabel.do {
                $0.font = .fontGuide(.detail1_reg)
                $0.textColor = .gray100
                $0.textAlignment = .center
            }
            
        case .twoLines:
            subTitleLabel.do {
                $0.font = .fontGuide(.detail1_reg)
                $0.textColor = .gray100
                $0.textAlignment = .center
                $0.numberOfLines = 2
            }
        }
    }
    
    private func setLayout() {
        view.addSubview(contentView)
        contentView.addSubviews(titleLabel, subTitleLabel, imageView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        switch pageType {
        case .oneLines:
            imageView.snp.makeConstraints {
                $0.top.equalTo(subTitleLabel.snp.bottom).offset(22)
                $0.bottom.equalTo(contentView.snp.bottom)
                $0.width.equalTo(375)
                $0.height.equalTo(378)
            }
        case .twoLines:
            imageView.snp.makeConstraints {
                $0.top.equalTo(subTitleLabel.snp.bottom).offset(1)
                $0.bottom.equalTo(contentView.snp.bottom)
                $0.width.equalTo(375)
                $0.height.equalTo(378)
            }
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(128)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(455)
        }
        
    }
}
