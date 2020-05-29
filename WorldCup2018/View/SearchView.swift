//
//  SearchView.swift
//  WorldCup2018
//
//  Created by 李祺 on 29/05/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit

class SearchView: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        self.searchBarStyle = UISearchBar.Style.prominent
        self.placeholder = " Search..."
        self.sizeToFit()
        self.isTranslucent = false
        self.backgroundImage = UIImage()
        self.tintColor = .white
        self.barTintColor = UIColor(named: "theme")
        self.searchTextField.textColor = .white
        self.showsCancelButton = true
    }
}
