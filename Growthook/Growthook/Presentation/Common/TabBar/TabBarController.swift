//
//  TabBarController.swift
//  Growthook
//
//  Created by KJ on 11/5/23.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private let tabBarHeight: CGFloat = 74
    private var tabs: [UIViewController] = []
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
        setTabBarUI()
        self.tabBar.frame.size.height = self.tabBarHeight + getSafeAreaBottomHeight()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tabBar.frame.size.height = self.tabBarHeight + getSafeAreaBottomHeight()
//    }
}

private extension TabBarController {
    
    func setTabBarItems() {
        
        tabs = [
            HomeViewController(),
            ActionListViewController(),
            MypageViewController()
        ]
        
        TabBarItemType.allCases.forEach {
            let tabBarItem = $0.setTabBarItem()
            tabs[$0.rawValue].tabBarItem = tabBarItem
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        setViewControllers(tabs, animated: false)

    }
    
    func setTabBarUI() {
        UITabBar.clearShadow()
        tabBar.tintColor = .green
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = CGColor(gray: 1, alpha: 1)
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 1
//        let fontAttributes = [
//            NSAttributedString.Key.font: .systemFont(ofSize: <#T##CGFloat#>, weight: <#T##UIFont.Weight#>)
//        ]
//        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
    
    func getSafeAreaBottomHeight() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let safeAreaInsets = windowScene.windows.first?.safeAreaInsets
            let bottomSafeAreaHeight = safeAreaInsets?.bottom ?? 0
            return bottomSafeAreaHeight
        }
        return 0
    }
}
