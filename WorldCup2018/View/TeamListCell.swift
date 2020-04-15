//
//  TeamListCell.swift
//  WorldCup2018
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit

class TeamListCell: UITableViewCell {
    var teamCellViewModel: TeamCellViewModel? {
        didSet {
            self.textLabel?.text = teamCellViewModel?.nameText
            self.textLabel?.textColor = .white
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(named: "theme")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
