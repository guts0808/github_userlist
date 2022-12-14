//
//  UserDetailTableViewCell.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/17.
//

import UIKit
import SkeletonView

class UserDetailTableViewCell: UITableViewCell {
    
    weak var repositoryName: UILabel!
    weak var repositoryDescription: UILabel!
    weak var starCount: UILabel!
    weak var language: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let repositoryName = UILabel()
        repositoryName.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        repositoryName.numberOfLines = 0
        repositoryName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(repositoryName)
        
        let repositoryDescription = UILabel()
        repositoryDescription.numberOfLines = 0
        repositoryDescription.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(repositoryDescription)
        
        let starCount = UILabel()
        starCount.setContentHuggingPriority(.required, for: .horizontal)
        starCount.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(starCount)
        
        let language = UILabel()
        language.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(language)
        
        NSLayoutConstraint.activate([
            repositoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            repositoryName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: repositoryName.trailingAnchor, constant: 8),
            repositoryDescription.topAnchor.constraint(equalTo: repositoryName.bottomAnchor, constant: 8),
            repositoryDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: repositoryDescription.trailingAnchor, constant: 8),
            starCount.topAnchor.constraint(equalTo: repositoryDescription.bottomAnchor, constant: 8),
            starCount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: starCount.bottomAnchor, constant: 8),
            language.leadingAnchor.constraint(equalTo: starCount.trailingAnchor, constant: 8),
            language.topAnchor.constraint(equalTo: repositoryDescription.bottomAnchor, constant: 8),
            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: language.trailingAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: language.bottomAnchor, constant: 8)
        ])
        
        self.repositoryName = repositoryName
        self.repositoryDescription = repositoryDescription
        self.starCount = starCount
        self.language = language
    }
    
    func setupSkeletonView() {
        isSkeletonable = true
        self.repositoryName.isSkeletonable = true
        self.repositoryDescription.isSkeletonable = true
        self.starCount.isSkeletonable = true
        self.language.isSkeletonable = true
        
        self.repositoryName.text = "          "
        self.repositoryDescription.text = "          "
        self.starCount.text = "          "
        self.language.text = "          "
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func style(repository: Repository) {
        repositoryName.text = repository.name
        repositoryDescription.text = repository.repositoryDescription
        starCount.text = "☆" + String(repository.stargazersCount ?? 0)
        self.language.text = repository.language
    }
}
