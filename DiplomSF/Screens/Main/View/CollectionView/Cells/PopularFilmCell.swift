//
//  PopularFilmCell.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import UIKit
import PinLayout

final class PopularFilmCell: UICollectionViewCell {
    // MARK: – UI Element's
    private lazy var imageView: UIImageView = {
        let imageView = ImagePoster()
        return imageView
    }()
    
    private lazy var raitingView = RaitingView()
    
    private lazy var titleLabel: UILabel = {
        let titleFilmLabel = TitleFilmLabel()
        return titleFilmLabel
    }()
    
    private lazy var genreLabel: UILabel = {
        let genreFilmLabel = GenreFilmLabel()
        return genreFilmLabel
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
        setupTitleLabel()
        setupGenreLabel()
    }
    
    // MARK: – Configuration's
    private func configureView() {
        contentView.backgroundColor = .systemBackground
    }
    
    // MARK: – Setup's
    private func setupUI() {
        addSubviews(imageView, titleLabel, genreLabel)
        imageView.addSubview(raitingView)
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
    
    private func setupTitleLabel() {
        titleLabel.pin
            .below(of: imageView)
            .horizontally()
            .marginTop(8)
            .wrapContent()
            .sizeToFit(.width)
    }
    
    private func setupGenreLabel() {
        genreLabel.pin
            .below(of: titleLabel)
            .horizontally()
            .marginTop(4)
            .sizeToFit(.width)
    }
    
    // MARK: – Set UI
    func setUI(raiting: Double, title: String, genre: String) {
        raitingView.configureRaiting(with: raiting)
        titleLabel.text = title
        genreLabel.text = genre
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    // MARK: – Getter
    func getImageView() -> UIImageView {
        return imageView
    }
}
