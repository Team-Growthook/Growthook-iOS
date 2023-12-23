//
//  InsightListCollectionViewCell.swift
//  Growthook
//
//  Created by KJ on 11/12/23.
//

import UIKit

import Then
import SnapKit
import RxSwift
import RxCocoa

final class InsightListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    let scrapButton = UIButton()
    private let titleLabel = UILabel()
    private let dueTimeLabel = UILabel()
    private let lockView = UIView()
    private let lockImageView = UIImageView()
    private let selectedView = UIView()
    private let selectedImageView = UIImageView()
    
    // MARK: - Properties
    
//    var scrapButtonTap: Observable<Void> {
//        return scrapButton.rx.tap.asObservable()
//    }
    private var disposeBag = DisposeBag()
    var scrapButtonTapHandler: (() -> Void)?
    var cellType: InsightStatus?
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectedView.isHidden = false
            } else {
                selectedView.isHidden = true
            }
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setCellStyle()
    }
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setCellStyle()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InsightListCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .gray400
        self.makeCornerRound(radius: 12)
        
        scrapButton.do {
            $0.setImage(ImageLiterals.Home.btn_scrap_light_off, for: .normal)
        }
        
        titleLabel.do {
            $0.text = "쑥쑥이들은 최고다."
            $0.font = .fontGuide(.body2_bold)
            $0.textColor = .white000
        }
        
        dueTimeLabel.do {
            $0.text = "00\(I18N.InsightList.lockInsight)"
            $0.font = .fontGuide(.detail3_reg)
            $0.textColor = .white000
        }
        
        lockView.do {
            $0.backgroundColor = .gray95
            $0.isHidden = true
        }
        
        lockImageView.do {
            $0.image = ImageLiterals.Home.icn_lock
        }
        
        selectedView.do {
            $0.backgroundColor = .green50
            $0.isHidden = true
        }
        
        selectedImageView.do {
            $0.image = ImageLiterals.Component.icn_check_white
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(scrapButton, titleLabel, dueTimeLabel, lockView, selectedView)
        lockView.addSubviews(lockImageView)
        selectedView.addSubviews(selectedImageView)
        
        scrapButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(scrapButton.snp.trailing)
        }
        
        dueTimeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(titleLabel)
        }
        
        lockView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lockImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        selectedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        selectedImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func configureCell(_ model: InsightList) {
        titleLabel.text = model.title
        dueTimeLabel.text = model.dueTime
        cellType = model.scrapStatus
        switch model.scrapStatus {
        case .dark:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_off, for: .normal)
            darkCellStyle()
        case .scrapDark:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_on, for: .normal)
            darkCellStyle()
        case .scrapLight:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_light_on, for: .normal)
        case .light:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_light_off, for: .normal)
        case .lock:
            lockCellStyle()
        }
    }
    
    func setCellStyle() {
        guard let cellType = cellType else { return }
        print("Setting cell  \(cellType)")
        switch cellType {
        case .dark:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_off, for: .normal)
            darkCellStyle()
        case .scrapDark:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_on, for: .normal)
            darkCellStyle()
        case .scrapLight:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_light_on, for: .normal)
        case .light:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_light_off, for: .normal)
        case .lock:
            lockCellStyle()
        }
    }
    
    private func lockCellStyle() {
        scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_off, for: .normal)
        backgroundColor = .gray900
        makeBorder(width: 0.5, color: .gray200)
        titleLabel.textColor = .gray200
        dueTimeLabel.textColor = .gray200
        lockView.isHidden = false
    }
    
    private func darkCellStyle() {
        backgroundColor = .gray900
        titleLabel.textColor = .gray200
        dueTimeLabel.textColor = .gray200
    }
    
    func selectedCell() {
        selectedView.isHidden = false
    }
    
    func unSelectedCell() {
        selectedView.isHidden = true
    }
    
    private func setAddTarget() {
        scrapButton.addTarget(self, action: #selector(scrapButtonTap), for: .touchUpInside)
    }
    
    func scrapButtonTapped() {
        print("---tap----")
        switch cellType {
        case .dark:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_on, for: .normal)
            cellType = .scrapDark
            return
        case .scrapDark:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_dark_off, for: .normal)
            cellType = .dark
            return
        case .light:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_light_on, for: .normal)
            cellType = .scrapLight
            return
        case .scrapLight:
            scrapButton.setImage(ImageLiterals.Home.btn_scrap_light_off, for: .normal)
            cellType = .light
            return
        default:
            return
        }
        print("Change cell style for \(cellType)")
    }
    
    @objc
    private func scrapButtonTap() {
        scrapButtonTapHandler?()
    }
}
