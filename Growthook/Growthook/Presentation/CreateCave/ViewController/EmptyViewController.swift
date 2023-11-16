//
//  EmptyViewController.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/15/23.
//

import UIKit

import SnapKit

final class EmptyViewController: UIViewController {

    private let emptySeedView = EmptySeedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setToast()
    }
}

extension EmptyViewController {

    private func setLayout() {
        view.addSubview(emptySeedView)
        emptySeedView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(280)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func setToast() {
        view.showToast(message: "dsdsfdfasd")
    }
    
    private func tapCloseButton(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: false)
        } else {
            self.dismiss(animated: false)
        }
    }
}
