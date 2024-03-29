//
//  MoviesPersonDetailCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation

protocol MoviesPersonDetailCoordinatorDelegate: AnyObject {
    func didSelectPhoto(person: Int)
}

final class MoviesPersonDetailCoordinator: CoordinatorType{
    var navigationController: NavigationType
    private var detailPersonFactory: MoviesPersonDetailFactory
    private weak var parentCoordinator: ParentCoordinator?
    var selectePhotoCoordinator: CoordinatorType?
    private weak var delegate: MoviesPersonDetailCoordinatorDelegate?
    var childCoordinators: [CoordinatorType] = []
    
    init(navigationController: NavigationType,
         detailPersonFactory: MoviesPersonDetailFactory,
         parentCoordinator: ParentCoordinator? = nil
    ) {
        self.navigationController = navigationController
        self.detailPersonFactory = detailPersonFactory
        self.parentCoordinator = parentCoordinator
    }
    func start() {
        let controller = detailPersonFactory.makeMoviesPersonDetailModule(coordinator: self)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(controller, animated: true) { [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.removeChildCoordinator(self)
        }
    }
    
}

extension MoviesPersonDetailCoordinator: PersonDetailViewControllerCoordinator {
    
    func didSelectPhoto(photoPath: [String], idSelected: IndexPath) {
        selectePhotoCoordinator = detailPersonFactory.makeSelectedPhotoModule(
            photoPath: photoPath,
            idSelected: idSelected,
            delegate: self
        )
        
        selectePhotoCoordinator?.start()
        guard let selectePhotoCoordinator = selectePhotoCoordinator else { return }
        navigationController.present(selectePhotoCoordinator.navigationController.rootViewController, animated: true)
        selectePhotoCoordinator.navigationController.dismissNavigation = {
            [weak self] in
            self?.selectePhotoCoordinator = nil
        }
    }
    
}
extension MoviesPersonDetailCoordinator: ParentCoordinator {}
extension MoviesPersonDetailCoordinator: SelectedPhotoCoordinatorDelegate {
    func presentedPhoto() {
        print("-----> Photo presented")
    }
    
    
}
