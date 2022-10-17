//
//  UserDetailTableViewHeaderView.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/17.
//

import UIKit

class UserDetailTableViewHeaderView: UITableViewHeaderFooterView {
    static let imageSize = CGSize(width: 60, height: 60)
    
    weak var userIcon: UIImageView!
    weak var userName: UILabel!
    weak var userFullName: UILabel!
    weak var follower: UILabel!
    weak var followee: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let userIcon = UIImageView()
        userIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userIcon)
        
        let userName = UILabel()
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        userName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userName)
        
        let userFullName = UILabel()
        userFullName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userFullName)
        
        let follower = UILabel()
        follower.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(follower)
        
        let followee = UILabel()
        followee.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(followee)
        
        NSLayoutConstraint.activate([
            userIcon.heightAnchor.constraint(equalToConstant: Self.imageSize.height),
            userIcon.widthAnchor.constraint(equalToConstant: Self.imageSize.width),
            userIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            userIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: userIcon.bottomAnchor, constant: 8),
            userName.leftAnchor.constraint(equalTo: userIcon.rightAnchor, constant: 16),
            userName.centerYAnchor.constraint(equalTo: userIcon.centerYAnchor, constant: -16),
            userFullName.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8),
            userFullName.leftAnchor.constraint(equalTo: userIcon.rightAnchor, constant: 16),
            follower.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            follower.topAnchor.constraint(equalTo: userIcon.bottomAnchor, constant: 16),
            follower.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            followee.centerYAnchor.constraint(equalTo: follower.centerYAnchor),
            followee.leftAnchor.constraint(equalTo: follower.rightAnchor, constant: 8),
            followee.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor),
            followee.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
