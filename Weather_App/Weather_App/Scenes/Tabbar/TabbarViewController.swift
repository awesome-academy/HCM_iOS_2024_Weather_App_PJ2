//
//  TabbarViewController.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import UIKit
import Then

final class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        tabBar.do {
            $0.tintColor = .blue
            $0.unselectedItemTintColor = .lightGray
            $0.backgroundColor = .white
        }
    }
}
