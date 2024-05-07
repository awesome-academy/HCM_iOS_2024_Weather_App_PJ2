//
//  CustomeNavigationController.swift
//  Weather_App
//
//  Created by ho.bao.an on 06/05/2024.
//

import UIKit

extension UIViewController {
    func customizeNavigationController() {
        navigationController?.navigationBar.backgroundColor = .blueGreen
    }
    
    func customizeSearchController(searchController: UISearchController) {
        if let searchBarTextField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            searchBarTextField.backgroundColor = .blueGreen
            searchBarTextField.backgroundColor = .white
            searchBarTextField.textColor = .black
            searchBarTextField.tintColor = .black
            if let searchIcon = searchBarTextField.leftView as? UIImageView {
                searchIcon.image = searchIcon.image?.withRenderingMode(.alwaysTemplate)
                searchIcon.tintColor = .black
            }
        }
        searchController.searchBar.backgroundColor = .blueGreen
        searchController.searchBar.addShadow()
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
    }
}
