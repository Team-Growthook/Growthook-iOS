//
//  TabBarItem.swift
//  Growthook
//
//  Created by KJ on 11/5/23.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case home
    case actionList
    case myPage
}

extension TabBarItemType {
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .actionList:
            return "액션리스트"
        case .myPage:
            return "마이페이지"
        }
    }
    
    var unSelectedIcon: UIImage {
        switch self {
        case .home:
            return ImageLiterals.TabBar.icn_home
        case .actionList:
            return ImageLiterals.TabBar.icn_writing
        case .myPage:
            return ImageLiterals.TabBar.icn_mypage
        }
    }
    
    var selectedIcon: UIImage {
        switch self {
        case .home:
            return ImageLiterals.TabBar.icn_selected_home
        case .actionList:
            return ImageLiterals.TabBar.icn_selected_writing
        case .myPage:
            return ImageLiterals.TabBar.icn_selected_mypage
        }
    }
    
    func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: title, image: unSelectedIcon, selectedImage: selectedIcon)
    }
}
