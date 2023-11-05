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
        setTabBarHeight()
    }
}

private extension TabBarController {
    
    func setTabBarItems() {
        
        tabs = [
            ViewController()
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
    
    func setTabBarHeight() {
        if let tabBar = self.tabBarController?.tabBar {
            let safeAreaBottomInset = self.view.safeAreaInsets.bottom
            let tabBarHeight = tabBar.bounds.height
            let newTabBarFrame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.y - safeAreaBottomInset, width: tabBar.frame.width, height: tabBarHeight + safeAreaBottomInset)
            tabBar.frame = newTabBarFrame
        }
    }
}
