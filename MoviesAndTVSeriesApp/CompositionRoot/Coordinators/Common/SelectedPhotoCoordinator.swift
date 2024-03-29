//
//  SelectedPhotoCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 01/02/24.
//

import Foundation

protocol SelectedPhotoCoordinatorDelegate: AnyObject {
    func presentedPhoto()
}

final class SelectedPhotoCoordinator: CoordinatorType {
    var navigationController: NavigationType
    private var selectedPhotoFactory: SelectedPhotoFactoryType
    private weak var delegate: SelectedPhotoCoordinatorDelegate?
    var idSelected: IndexPath
    
    init(navigationController: NavigationType,
         selectedPhotoFactory: SelectedPhotoFactoryType,
         delegate: SelectedPhotoCoordinatorDelegate,
         idSelected: IndexPath
    ) {
        self.navigationController = navigationController
        self.selectedPhotoFactory = selectedPhotoFactory
        self.delegate = delegate
        self.idSelected = idSelected
    }
    
    func start() {
        let controller = selectedPhotoFactory.makeSelectedPhotoModule(coordinator: self)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.viewControllers = [controller]
    }
}

extension SelectedPhotoCoordinator: SelectedPhotosPersonViewControllerCoordinator {
    func didDisapperView() {
        print("Disapper view")
    }
}
