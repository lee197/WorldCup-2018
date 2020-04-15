//
//  TeamFlagImageCell.swift
//  WorldCup2018
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit

class TeamFlagImageCell: UITableViewCell {
    let flageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(flageImageView)
        self.backgroundColor = UIColor(named: "theme")
        let flageImageViewConstraints = [
            flageImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            flageImageView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            flageImageView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20),
            flageImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 0),
            flageImageView.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(flageImageViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: image.size.height / image.size.width).isActive = true
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
