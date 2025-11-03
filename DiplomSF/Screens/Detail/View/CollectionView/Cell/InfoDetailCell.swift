//
//  InfoCell.swift
//  DiplomSF
//
//  Created by Алексей on 02.10.2025.
//

import UIKit
import PinLayout

final class InfoDetailCell: UICollectionViewCell {
    // MARK: – Cell ID
    static var id: String {
        String(describing: self)
    }
    
    // MARK: – Variable
    var onFavoriteButtonTapped: (() -> Void)?
    
    // MARK: – UI Element's
    private lazy var hStack: UIView = {
        let view = UIView()
        view.addSubviews(raitingView,originalTitleLabel)
        return view
    }()
    
    private lazy var imagePoster: UIImageView = {
        let imageView = ImagePoster()
        return imageView
    }()
    
    private lazy var favoriteButtonView: FavoriteButtonView = {
        let view = FavoriteButtonView { [weak self] in
            guard let self else { return }
            self.onFavoriteButtonTapped?()
        }
        return view
    }()
    
    private lazy var titleOverview: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = DetailTitleLabel()
        return label
    }()

    private lazy var raitingView: RaitingView = {
        let view = RaitingView()
        return view
    }()
    
    private lazy var originalTitleLabel: UILabel = {
        let label = DetailOriginalTitleLabel()
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = DetailOriginalTitleLabel()
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
        setupStackHorizontal()
        setupGenre()
        setupFavoriteButtonView()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let totalHeight =
            imagePoster.frame.maxY +
            8 + titleLabel.frame.height +
            4 + raitingView.frame.height +
            8 + genreLabel.frame.height +
            4 + dateLabel.frame.height

        var frame = layoutAttributes.frame
        frame.size.height = totalHeight
        layoutAttributes.frame = frame
        return layoutAttributes
    }
        
    // MARK: – Setup's
    private func setupUI() {
        contentView.addSubviews(imagePoster, hStack, dateLabel, titleLabel, genreLabel)
        imagePoster.addSubview(favoriteButtonView)
    }
    
    private func setupImage() {
        imagePoster.pin
            .top(0)
            .horizontally(0)
            .height(600)
    }
    
    private func setupFavoriteButtonView() {
        favoriteButtonView.pin
            .top(16)
            .right(32)
            .wrapContent()
    }
    
    private func setupTitle() {
        titleLabel.pin
            .below(of: imagePoster).marginTop(8)
            .horizontally(16)
            .sizeToFit(.width)
    }
    
    // Исправить вертикальное отображение
    private func setupStackHorizontal() {
        hStack.pin
            .below(of: titleLabel).marginTop(4)
            .hCenter(to: titleLabel.edge.hCenter)
            .sizeToFit()

        raitingView.pin
            .left()
            .top()
            .sizeToFit()
        
        originalTitleLabel.pin
            .after(of: raitingView, aligned: .center)
            .marginLeft(8)
            .sizeToFit()
        
        hStack.pin.wrapContent()
        
        dateLabel.pin
            .below(of: hStack).marginTop(4)
            .hCenter(to: hStack.edge.hCenter)
            .sizeToFit()
    }
    
    private func setupGenre() {
        genreLabel.pin
            .below(of: dateLabel).marginTop(8)
            .horizontally(16)
            .sizeToFit(.width)
    }
    
    func setUI(title: String, genre: String, originalTitle: String, voteAverage: Double, image: UIImage? = nil, date: String, isFavorite: Bool) {
        originalTitleLabel.text = originalTitle
        raitingView.configureRaiting(with: voteAverage)
        titleLabel.text = title
        genreLabel.text = genre
        dateLabel.text = "В кино с \(date.convertDate())"
        favoriteButtonView.update(isSelected: isFavorite)

        if image == nil {
            imagePoster.image = UIImage(systemName: "photo")
        } else {
            imagePoster.image = image
        }
    }
}
