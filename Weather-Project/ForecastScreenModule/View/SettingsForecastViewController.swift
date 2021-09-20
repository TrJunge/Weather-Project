//
//  SettingsForecastViewController.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 20.09.21.
//

import UIKit

extension ForecastViewController {
    func setNavigationBar() -> UINavigationBar {
        let navBar = UINavigationBar()
        navBar.prefersLargeTitles = false
        navBar.isTranslucent = false
        navBar.barTintColor = .systemBackground
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem()
        navBar.setItems([navItem], animated: true);
        return navBar
    }
    
    func setTableView() -> UITableView {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
}

// MARK: setupSubviews and setupConstraint
extension ForecastViewController {
    func setupSubview() {
        self.view.addSubview(navigationBar)
        self.view.addSubview(tableView)
    }
    
    func setupConstraint() {
        navigationBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
