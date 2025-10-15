//
//  SearchFilmCell.swift
//  DiplomSF
//
//  Created by Алексей on 30.09.2025.
//

import UIKit
import PinLayout
import SDWebImage

final class SearchFilmCell: UITableViewCell {
    // MARK: – Cell ID
    static var id: String {
        String(describing: self)
    }
    
    // MARK: – UI Element's
    private lazy var photoImage: UIImageView = {
        let imageView = ImagePoster()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = TitleFilmLabel()
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = GenreFilmLabel()
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: – Initializate
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupPhotoImage()
        setupLabels()
    }
    
    // MARK: – Configuration's
    private func configureView() {
        contentView.backgroundColor = .systemBackground
    }
    
    // MARK: – Setup's
    private func setupUI() {
        addSubviews(photoImage, titleLabel, genreLabel)
    }
    
    private func setupPhotoImage() {
        photoImage.pin
            .left(24)
            .vCenter()
            .height(90)
            .width(60)
    }
    
    private func setupLabels() {
        titleLabel.pin
            .after(of: photoImage).marginLeft(16)
            .right(24)
            .sizeToFit(.width)
        
        genreLabel.pin
            .below(of: titleLabel).marginTop(2)
            .after(of: photoImage).marginLeft(16)
            .right(24)
            .sizeToFit(.width)
        
        let labelsHeight = titleLabel.frame.height + 2 + genreLabel.frame.height
        let startY = (contentView.frame.height - labelsHeight) / 2
        
        titleLabel.pin.top(startY)
        genreLabel.pin.top(titleLabel.frame.maxY + 2)
    }

    func configure(title: String, genre: String, posterPath: String) {
        titleLabel.text = title
        genreLabel.text = genre
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") {
            photoImage.sd_setImage(with: url, placeholderImage: nil, options: [.avoidAutoSetImage, .scaleDownLargeImages]) { [weak self] image, _, _, _ in
                guard let self else { return }
                self.photoImage.image = image
            }
        } else {
            photoImage.image = nil
        }
    }
}
