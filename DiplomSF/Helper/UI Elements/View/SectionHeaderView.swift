//
//  HeaderView.swift
//  DiplomSF
//
//  Created by Алексей on 15.09.2025.
//

import UIKit
import PinLayout

final class SectionHeaderView: UICollectionReusableView {
    // MARK: – Cell ID
    static var id: String {
        String(describing: self)
    }
    
    // MARK: – UI Element's
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    // MARK: – Initializate
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTitleLabel()
    }
    
    // MARK: – Configuration's
    func configure(with text: String) {
        titleLabel.text = text
    }
    
    // MARK: – Setup's
    private func setupTitleLabel() {
        titleLabel.pin
            .top(24)
            .horizontally(8)
            .height(28)
    }
}

