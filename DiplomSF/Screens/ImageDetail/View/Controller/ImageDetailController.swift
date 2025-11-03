//
//  ImageDetailController.swift
//  DiplomSF
//
//  Created by Алексей on 22.10.2025.
//

import UIKit
import PinLayout

final class ImageDetailController: UIViewController {
    // MARK: – Instance's
    private let collectionView = ImageDetailCollection()
    private let dataSource = ImageDetailDataSource()
    private let delegaete = ImageDetailDelegate()
    
    // MARK: – Variable's
    var presenter: ImageDetailPresenterProtocol!
    var coordinator: CoordinatorProtocol!
    private var didLoadCollection: Bool = false
    
    // MARK: – Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureCollectionViewConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    // MARK: – Setup's
    
    // MARK: – Configuration's
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegaete
    }
    
    private func configureCollectionViewConstraints() {
        collectionView.pin
            .top(view.pin.safeArea.top)
            .bottom(view.pin.safeArea.bottom)
            .horizontally()
    }
}

extension ImageDetailController: ImageDetailViewProtocol {
    func loadModel(model: ImageModel) {
        dataSource.model = model

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()

            let indexPath = IndexPath(item: model.index.item, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}
