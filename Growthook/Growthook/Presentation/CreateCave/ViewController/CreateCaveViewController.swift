//
//  CreateCaveViewController.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/12/23.
//

import UIKit

import SnapKit
import Then

class CreateCaveViewController: UIViewController {
    
    private let createCaveView = CreateCaveView()
    override func viewDidLoad() {
        super.viewDidLoad()
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

}

@available(iOS 17.0, *)
#Preview {
    let vc = CreateCaveView()
    return vc
}
