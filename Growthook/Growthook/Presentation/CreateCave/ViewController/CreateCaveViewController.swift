//
//  CreateCaveViewController.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/12/23.
//

import UIKit

import RxCocoa
import RxSwift
import Then

final class CreateCaveViewController: UIViewController {
    private var viewModel = CreateCaveViewModel()
    private let disposeBag = DisposeBag()
    
    private let createCaveView = CreateCaveView()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
        self.view = createCaveView
    }
    
    deinit {
        print(#function)
    }
}

extension CreateCaveViewController {
    private func bindViewModel() {
        createCaveView.nameTextFieldView.textField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind { [weak self] value in
                guard let self else { return }
                self.viewModel.inputs.setName(with: value)
            }
            .disposed(by: disposeBag)
        
        createCaveView.nameTextFieldView.textField.rx.controlEvent([.editingDidBegin])
            .bind { [weak self] in
                self?.setUpAnimation()
                self?.createCaveView.nameTextFieldView.setFocus()
            }
            .disposed(by: disposeBag)
        
        createCaveView.nameTextFieldView.textField.rx.controlEvent([.editingDidEnd])
            .bind { [weak self] in
                if(self?.createCaveView.nameTextFieldView.textField.text?.isEmpty == true) {
                    
                    self?.createCaveView.nameTextFieldView.setEmpty()
                }
                else {
                    self?.createCaveView.nameTextFieldView.setDone()
                }
                self?.setDownAnimation()
            }
            .disposed(by: disposeBag)
        
        createCaveView.nameTextFieldView.textField.rx.controlEvent([.editingDidEndOnExit])
            .bind { [weak self] in
                self?.setNextTextField()
            }.disposed(by: disposeBag)
        
        createCaveView.descriptionTextFieldView.textField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind { [weak self] value in
                guard let self else { return }
                self.viewModel.inputs.setDescription(with: value)
            }
            .disposed(by: disposeBag)
        
        createCaveView.descriptionTextFieldView.textField.rx.controlEvent([.editingDidBegin])
            .bind { [weak self] in
                self?.setUpAnimation()
                self?.createCaveView.descriptionTextFieldView.setFocus()
            }
            .disposed(by: disposeBag)
        
        createCaveView.descriptionTextFieldView.textField.rx.controlEvent([.editingDidEnd])
            .bind { [weak self] in
                if(self?.createCaveView.descriptionTextFieldView.textField.text?.isEmpty == true) {
                    
                    self?.createCaveView.descriptionTextFieldView.setEmpty()
                }
                else {
                    self?.createCaveView.descriptionTextFieldView.setDone()
                }
                self?.setDownAnimation()
            }
            .disposed(by: disposeBag)
        
        createCaveView.switchButton.rx.isOn
            .subscribe { [weak self] value in
                if value == true {
                    self?.setAlert()
                }
            }
            .disposed(by: disposeBag)
        
        createCaveView.createCaveButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.viewModel.inputs.createButtonTapped()
                self.pushToEmptyViewController()
            }
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .map { $0 ? true : false }
            .bind(to: createCaveView.createCaveButton.rx.enableStatus)
            .disposed(by: disposeBag)
    }
    
    func setUpAnimation() {
        UIView.animate(withDuration: 0.4, animations: { [self] in
            createCaveView.containerView.frame.origin.y -= 50
            createCaveView.createCaveButton.frame.origin.y -= SizeLiterals.Screen.screenHeight < 812 ? 50 : 280
            createCaveView.setLayoutUp()
        })
    }
    
    func setDownAnimation() {
        UIView.animate(withDuration: 0.4, animations: { [self] in
            createCaveView.containerView.frame.origin.y += 50
            createCaveView.createCaveButton.frame.origin.y += SizeLiterals.Screen.screenHeight < 812 ? 50 : 280
            createCaveView.setLayoutDown()
        })
    }
    
    private func setAlert() {
        AlertBuilder(viewController: self)
            .setTitle("내 동굴에 친구를 초대해\n인사이트를 공유해보세요")
            .setMessage("해당 기능은 추후 업데이트 예정이에요:)")
            .addActionConfirm("확인") {
                print("확인!!")
            }
            .show()
        setSwitchOff()
    }
    
    private func setSwitchOff() {
        createCaveView.switchButton.setOn(false, animated: true)
    }
    
    private func setNextTextField() {
        createCaveView.descriptionTextFieldView.setFocus()
        createCaveView.descriptionTextFieldView.textField.becomeFirstResponder()
    }
    
    private func pushToEmptyViewController() {
        let emptyViewController = EmptyViewController()
        emptyViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(emptyViewController, animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    let vc = CreateCaveView()
    return vc
}
