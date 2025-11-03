//
//  ImageCell.swift
//  DiplomSF
//
//  Created by Алексей on 22.10.2025.
//

import UIKit
import PinLayout
import SDWebImage

final class ImageCell: UICollectionViewCell {
    // MARK: – Cell ID
    static var id: String {
        String(describing: self)
    }
    
    // MARK: – UI Element's
    private lazy var photoImage: UIImageView = {
        let imageView = ImagePoster()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var countImagesLabel: UILabel = {
        let label = DetailGenreLabel()
        label.textAlignment = .center
        label.textColor = .black
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
        configureContraints()
    }
    
    // MARK: – Configuration's
    private func configureContraints() {
        // Как сделать корректное отображение на всю ширину?
        // Поработать с пином тут при горизонтальном отображении

        photoImage.pin
            .vCenter()
            .horizontally()
            .height(250)

        countImagesLabel.pin
            .below(of: photoImage)
            .horizontally()
            .marginTop(8)
            .sizeToFit(.width)
    }
    
    // MARK: – Setup's
    private func setupUI() {
        contentView.addSubviews(photoImage, countImagesLabel)
    }
    
    func setUI(url: URL?, countImages: String) {
        photoImage.sd_setImage(with: url,
                               placeholderImage: nil,
                               options: [.continueInBackground, .highPriority, .avoidAutoCancelImage, .scaleDownLargeImages]) { [weak self] image, _, _, _ in
            guard let self else { return }
            self.photoImage.image = image
        }
        
        countImagesLabel.text = countImages
    }
}
