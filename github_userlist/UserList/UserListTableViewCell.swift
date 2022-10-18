//
//  UserListTableViewCell.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/17.
//

import UIKit
import Nuke
import SkeletonView

class UserListTableViewCell: UITableViewCell {
    static let imageSize = CGSize(width: 44, height: 44)
    weak var userIcon: UIImageView!
    weak var label: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Self.imageSize.height / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: Self.imageSize.height),
            imageView.widthAnchor.constraint(equalToConstant: Self.imageSize.width),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        
        userIcon = imageView
        self.label = label
    }
    
    func setupSkeletonView() {
        isSkeletonable = true
        userIcon.isSkeletonable = true
        self.label.isSkeletonable = true
        self.label.text = "                         "
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style(model: User) {
        if let url = URL(string: model.avatarURL) {
            Nuke.loadImage(with: url, into: userIcon)
        }
        label.text = model.login
    }
}
