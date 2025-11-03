//
//  DetailPhotoCell.swift
//  DiplomSF
//
//  Created by Алексей on 18.10.2025.
//

import UIKit
import PinLayout
import SDWebImage

final class FramesDetailCell: UICollectionViewCell {
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
    
    // MARK: – Initializate
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupPhotoImage()
    }
    
    // MARK: – Configuration's
    private func configureView() {
        contentView.backgroundColor = .systemBackground
    }
    
    // MARK: – Setup's
    private func setupUI() {
        contentView.addSubviews(photoImage)
    }
    
    private func setupPhotoImage() {
        photoImage.pin.all()
    }
    
    func setUI(url: URL?) {
        photoImage.sd_setImage(with: url, placeholderImage: nil,
                               options: [.continueInBackground, .highPriority, .avoidAutoCancelImage, .scaleDownLargeImages]) { [weak self] image, _, _, _ in
            
            guard let self else { return }
            self.photoImage.image = image
        }
    }
}
