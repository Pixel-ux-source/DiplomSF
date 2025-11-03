//
//  PopularFilmCell.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import UIKit
import PinLayout
import SDWebImage

final class PopularFilmCell: UICollectionViewCell {
    // MARK: – UI Element's
    private lazy var imageView: UIImageView = {
        let imageView = ImagePoster()
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    // MARK: – Variable
    var onFavoriteButtonTapped: (() -> Void)?
    
    private lazy var raitingView = RaitingView()
    
    private lazy var favoriteView: FavoriteButtonView = {
        let view = FavoriteButtonView { [weak self] in
            guard let self else { return }
            self.onFavoriteButtonTapped?()
        }
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleFilmLabel = TitleFilmLabel()
        return titleFilmLabel
    }()
    
    // MARK: – Cell ID
    static var id: String {
        String(describing: self)
    }
    
    // MARK: – Initializate
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureView()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupImageView()
        setupRaitingView()
        setupFavoriteView()
        setupTitleLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
        titleLabel.text = nil
        raitingView.configureRaiting(with: 0)
    }
    
    // MARK: – Configuration's
    private func configureView() {
        contentView.backgroundColor = .systemBackground
    }
    
    // MARK: – Setup's
    private func setupUI() {
        contentView.addSubviews(imageView, titleLabel)
        imageView.addSubviews(raitingView, favoriteView)
    }
    
    private func setupImageView() {
        imageView.pin
            .top()
            .horizontally()
            .height(250)
    }
    
    private func setupRaitingView() {
        raitingView.pin
            .top(8)
            .left(8)
            .wrapContent()
    }
    
    private func setupFavoriteView() {
        favoriteView.setNeedsLayout()
        favoriteView.layoutIfNeeded()
        favoriteView.pin
            .top(8)
            .right(8)
    }
    
    private func setupTitleLabel() {
        titleLabel.pin
            .below(of: imageView)
            .horizontally()
            .marginTop(8)
            .wrapContent()
            .sizeToFit(.width)
    }
    
    // MARK: – Set UI
    func setUI(with model: PopularFilmsModel) {
        raitingView.configureRaiting(with: model.voteAverage)
        titleLabel.text = model.title
        favoriteView.update(isSelected: model.isFavorite)
        
        let imagePath = model.posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(imagePath)")
        imageView.sd_setImage(with: url,
                          placeholderImage: nil,
                          options: [.continueInBackground, .highPriority, .avoidAutoSetImage, .scaleDownLargeImages]) { [weak self] image, _, _, _ in
            guard let self else { return }
            self.imageView.image = image
        }
    }

    func setFavoriteSelected(_ isSelected: Bool) {
        favoriteView.update(isSelected: isSelected)
    }
}
