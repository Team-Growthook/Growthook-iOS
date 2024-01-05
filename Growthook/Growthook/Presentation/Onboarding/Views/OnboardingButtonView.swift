//
//  OnboardingButtonView.swift
//  Growthook
//
//  Created by 천성우 on 1/1/24.
//

import UIKit

import SnapKit
import Then

protocol OnboardingButtonViewDelegate: AnyObject {
    func onboardingButtonTapped(_ buttonView: OnboardingButtonView)
}

final class OnboardingButtonView: BaseView {
    
    // MARK: - UI Components
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    
    // MARK: - Properties
    
    weak var delegate: OnboardingButtonViewDelegate?
    
    var isSelected = false {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Initializer
    
    init(title: String, image: UIImage) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        imageView.image = image
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleButtonTap))
         addGestureRecognizer(tapGesture)
         
         updateUI()
    }
    
    // MARK: - UI Components Property
    
    override func setStyles() {        
        contentView.do {
            $0.backgroundColor = .gray400
            $0.layer.cornerRadius = 18
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray400.cgColor
        }
        
        titleLabel.do {
            $0.font = .fontGuide(.body2_reg)
            $0.textColor = .white000
            $0.numberOfLines = 2
        }
        
        imageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        addSubviews(contentView)
        contentView.addSubviews(titleLabel, imageView)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        imageView.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().offset(-20)
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(154)
            $0.height.equalTo(160)
        }
    }
    
    // MARK: - Methods
    
    private func updateUI() {
        if isSelected {
            titleLabel.textColor = .green200
            contentView.layer.borderColor = UIColor.green200.cgColor
            contentView.backgroundColor = .gray500
        } else {
            titleLabel.textColor = .white000
            contentView.layer.borderColor = UIColor.gray400.cgColor
            contentView.backgroundColor = .gray400
        }
    }

    
    // MARK: - @objc Methods
    
    
    @objc 
    private func handleButtonTap() {
        isSelected.toggle()
        updateUI()
        delegate?.onboardingButtonTapped(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
