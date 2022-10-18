//
//  UserDetailTableViewHeaderView.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/17.
//

import UIKit
import Nuke
import SkeletonView

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
        userIcon.clipsToBounds = true
        userIcon.layer.cornerRadius = Self.imageSize.height / 2
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
        follower.setContentHuggingPriority(.required, for: .horizontal)
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
            userName.leftAnchor.constraint(equalTo: userIcon.rightAnchor, constant: 16),
            userName.centerYAnchor.constraint(equalTo: userIcon.centerYAnchor, constant: -16),
            userFullName.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8),
            userFullName.leftAnchor.constraint(equalTo: userIcon.rightAnchor, constant: 16),
            follower.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            follower.topAnchor.constraint(equalTo: userIcon.bottomAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: follower.bottomAnchor, constant: 8),
            followee.centerYAnchor.constraint(equalTo: follower.centerYAnchor),
            followee.leadingAnchor.constraint(equalTo: follower.trailingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: followee.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: followee.bottomAnchor, constant: 8)
        ])
        
        self.userIcon = userIcon
        self.userName = userName
        self.userFullName = userFullName
        self.follower = follower
        self.followee = followee
        
    }
    
    func setupSkeletonView() {
        isSkeletonable = true
        self.userIcon.isSkeletonable = true
        self.userName.isSkeletonable = true
        self.userFullName.isSkeletonable = true
        self.follower.isSkeletonable = true
        self.followee.isSkeletonable = true
        
        self.userName.text = "          "
        self.userFullName.text = "          "
        self.follower.text = "     "
        self.followee.text = "     "
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func style(userDetail: UserDetail) {
        if let url = URL(string: userDetail.avatarURL) {
            Nuke.loadImage(with: url, into: userIcon)
        }
        userName.text = userDetail.login
        userFullName.text = userDetail.name
        follower.text = "\(userDetail.followers)フォロワー"
        followee.text = "\(userDetail.following)フォロワー中"
    }
}
