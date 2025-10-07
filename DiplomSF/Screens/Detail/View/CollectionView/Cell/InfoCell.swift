//
//  InfoCell.swift
//  DiplomSF
//
//  Created by Алексей on 02.10.2025.
//

import UIKit
import PinLayout

final class InfoCell: UICollectionViewCell {
    // MARK: – Cell ID
    static var id: String {
        String(describing: self)
    }
    
    // MARK: – UI Element's
    private lazy var imagePoster: UIImageView = {
        let imageView = ImagePoster()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = DetailTitleLabel()
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = DetailGenreLabel()
        return label
    }()
    
    // MARK: – Initializate
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupImage()
        setupTitle()
        setupGenre()
    }
    
    // MARK: – Configuration's
    private func setupUI() {
        contentView.addSubviews(imagePoster, titleLabel, genreLabel)
    }
    
    // MARK: – Setup's
    private func setupImage() {
        imagePoster.pin
            .top(0)
            .horizontally(0)
            .height(600)
    }
    
    private func setupTitle() {
        titleLabel.pin
            .below(of: imagePoster).marginTop(8)
            .horizontally(24)
            .sizeToFit(.width)
    }
    
    private func setupGenre() {
        genreLabel.pin
            .below(of: titleLabel).marginTop(8)
            .horizontally(24)
            .bottom(8)
            .sizeToFit(.width)
    }
    
    func setUI(title: String, genre: String, image: UIImage? = nil) {
        titleLabel.text = title
        genreLabel.text = genre
        if image == nil {
            imagePoster.image = UIImage(systemName: "photo")
        } else {
            imagePoster.image = image
        }
    }
}
