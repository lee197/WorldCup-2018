//
//  TeamDetailCell.swift
//  WorldCup2018
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit

class TeamDetailCell: UITableViewCell {
    var teamDetailCellViewModel: TeamDetailCellViewModel? {
        didSet {
            self.titleLabel.text = teamDetailCellViewModel?.nameText
            self.detailLabel.text = teamDetailCellViewModel?.detailText
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        setTitleLabelConstraints()
        setDetailLabelConstraints()
        self.backgroundColor = UIColor(named: "theme")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabelConstraints() {
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    private func setDetailLabelConstraints() {
        let detailLabelConstraints = [
            detailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            detailLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            detailLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(detailLabelConstraints)
    }
    
    
    
}
