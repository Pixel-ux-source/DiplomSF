//
//  RaitingView.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit
import PinLayout

final class RaitingView: UIView {
    // MARK: – UI Element's
    private lazy var raitingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        return label
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
        setupRaitingLabel()
    }
    
    // MARK: – Configuration's
    func configureRaiting(with raiting: Double) {
        raitingLabel.text = raiting.toString(decimals: 1)
        configureView(for: raiting)
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func configureView(for raiting: Double) {
        switch raiting {
        case 1..<5:
            backgroundColor = .systemRed
        case 5..<7:
            backgroundColor = .gray
        case 7...10:
            backgroundColor = .systemGreen
        default:
            break
        }
    }
    
    // MARK: – Setup's
    private func setupUI() {
        addSubview(raitingLabel)
    }
    
    private func setupRaitingLabel() {
        raitingLabel.pin.sizeToFit()
        pin.wrapContent(padding: UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8))
    }
}
