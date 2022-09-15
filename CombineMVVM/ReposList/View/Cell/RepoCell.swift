//
//  RepoCell.swift
//  CombineMVVM
//
//  Created by Thuong Nguyen on 9/15/22.
//

import UIKit
import SDWebImage

final class RepoCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageColorImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 3.0
        avatarImageView.layer.cornerCurve = .continuous
        avatarImageView.layer.masksToBounds = true
    }
    
    func configCell(_ repo: Repo?) {
        avatarImageView.sd_setImage(with: repo?.owner?.avatarUrl, completed: nil)
        nameLabel.text = repo?.owner?.login
        repoNameLabel.text = repo?.name
        descriptionLabel.text = repo?.description
        starCountLabel.text = String(repo?.stargazersCount ?? 0)
        languageLabel.text = repo?.language
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
}
