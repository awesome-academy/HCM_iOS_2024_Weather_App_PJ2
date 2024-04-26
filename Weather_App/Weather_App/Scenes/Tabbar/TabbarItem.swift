//
//  TabbarItem.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import UIKit
import RxSwift
import Localize_Swift

enum TabbarItem {
    case map
    case favorite

    var item: UITabBarItem {
        switch self {
        case .map:
            return UITabBarItem(title: "map".localized(),
                                image: UIImage(systemName: "map.fill"),
                                selectedImage: nil)
        case .favorite:
            return UITabBarItem(title: "favorite".localized(),
                                image: Asset.iconFavorite.image,
                                selectedImage: nil)
        }
    }
}
