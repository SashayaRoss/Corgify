//
//  SearchResultsSubtitleTableViewCell.swift
//  Corgify
//
//  Created by Aleksandra Kustra on 26/03/2023.
//

import UIKit
import SDWebImage

final class SearchResultsSubtitleTableViewCell: UITableViewCell {
    static let identifier = "SearchResultsSubtitleTableViewCell"

    private let label: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.height - 10
        iconImageView.frame = CGRect(
            x: 10,
            y: 5,
            width: imageSize,
            height: imageSize)
        let labelHeight = contentView.height / 2
        label.frame = CGRect(
            x: iconImageView.right + 10,
            y: 0,
            width: contentView.width - iconImageView.right - 15,
            height: labelHeight)
        subtitleLabel.frame = CGRect(
            x: iconImageView.right + 10,
            y: label.bottom,
            width: contentView.width - iconImageView.right - 15,
            height: labelHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        subtitleLabel.text = nil
    }
    
    func configure(with viewModel: SearchResultsSubtitleTableViewCellViewModel) {
        label.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        iconImageView.sd_setImage(with: viewModel.imageURL)
    }
}

