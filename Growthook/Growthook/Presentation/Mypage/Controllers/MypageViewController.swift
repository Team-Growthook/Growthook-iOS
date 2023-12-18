//
//  MypageViewController.swift
//  Growthook
//
//  Created by KJ on 11/5/23.
//

import UIKit

import Kingfisher
import RxSwift

final class MypageViewController: BaseViewController {

    private let viewModel = MyPageViewModel()
    private let disposeBag = DisposeBag()
    
    private let profileImageView = UIImageView()
    private let profileNameLabel = UILabel()
    private let editMyInfoButton = UIButton()
    private let earnedThookView = MyPageThookBoxView(type: .earned)
    private let spentThookView = MyPageThookBoxView(type: .spent)
    private let myPageListTableView = UITableView()

    override func bindViewModel() {
        viewModel.outputs.userProfileImage
            .bind { [weak self] imageUrl in
                guard let self = self, let url = URL(string: imageUrl) else { return }
                
                self.profileImageView.kf.setImage(with: url, options: [
                    .cacheOriginalImage,
                    .transition(.fade(0.4))
                ], completionHandler: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.userProfileName
            .bind { [weak self] name in
                guard let self else { return }
                self.profileNameLabel.text = name
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.userEarnedThookCount
            .bind { [weak self] earned in
                guard let self else { return }
                self.earnedThookView.setThookCount(with: earned)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.userSpentThookCount
            .bind { [weak self] spent in
                guard let self else { return }
                self.spentThookView.setThookCount(with: spent)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.outputs.myPageComponentsList, viewModel.outputs.versionNumber)
            .map { (list, version) in
                var modifiedList = list
                if let firstIndex = modifiedList.firstIndex(of: "버전 정보") {
                    modifiedList[firstIndex] = "버전 정보 \(version)"
                }
                return modifiedList
            }
            .bind(to: myPageListTableView.rx.items(cellIdentifier: MyPageListTableViewCell.className, cellType: MyPageListTableViewCell.self)) { row, data, cell in
                cell.configureWith(componentTitle: data)
                /// 조금 더 좋은 방식으로 짰으면 좋겠는데... 흠...
                if row == 5 {
                    cell.setLogOutStyle()
                }
            }
            .disposed(by: disposeBag)
        
        myPageListTableView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let self else { return }
                let row = indexPath.row
                let inputs = self.viewModel.inputs
                switch row {
                case 0:
                    // 사용법
                    inputs.growthookManualDidTap()
                case 1:
                    // 공지사항
                    inputs.announcementDidTap()
                case 2:
                    // 자주 묻는 질문
                    inputs.frequentQuestionsDidTap()
                case 3:
                    // 약관 및 정책
                    inputs.termsAndPoliciesDidTap()
                case 4:
                    // 버전 정보
                    break
                case 5:
                    // 로그아웃
                    inputs.logOutDidTap()
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }

    override func setStyles() {
        view.backgroundColor = .gray700
        
        profileImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .gray900
            $0.makeCornerRound(radius: 41)
        }
        
        profileNameLabel.do {
            $0.font = .fontGuide(.head1)
            $0.textColor = .white000
            $0.textAlignment = .center
        }
        
        editMyInfoButton.do {
            $0.makeCornerRound(radius: 7)
            $0.setTitle("내 정보 보기", for: .normal)
            $0.titleLabel?.font = .fontGuide(.detail2_reg)
            $0.setTitleColor(.gray200, for: .normal)
            $0.backgroundColor = .gray600
        }
        
        myPageListTableView.do {
            $0.rowHeight = 60
            $0.bounces = true
            $0.backgroundColor = .gray600
            $0.separatorColor = .gray400
            $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0   )
        }
    }
    
    override func setRegister() {
        myPageListTableView.register(MyPageListTableViewCell.self, forCellReuseIdentifier: MyPageListTableViewCell.className)
    }

    override func setLayout() {
        view.addSubviews(
            profileImageView, profileNameLabel, editMyInfoButton,
            earnedThookView, spentThookView, myPageListTableView
        )
        
        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(82)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
        
        profileNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)
        }
        
        editMyInfoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(98)
            $0.height.equalTo(30)
            $0.top.equalTo(profileNameLabel.snp.bottom).offset(10)
        }
        
        earnedThookView.snp.makeConstraints {
            $0.top.equalTo(editMyInfoButton.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(18)
            $0.trailing.equalTo(view.snp.centerX).offset(-5)
            $0.height.equalTo(100)
        }
        
        spentThookView.snp.makeConstraints {
            $0.centerY.equalTo(earnedThookView)
            $0.leading.equalTo(view.snp.centerX).offset(5)
            $0.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(100)
        }
        
        myPageListTableView.snp.makeConstraints {
            $0.top.equalTo(earnedThookView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
