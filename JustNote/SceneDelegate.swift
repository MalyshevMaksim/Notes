//
//  SceneDelegate.swift
//  JustNote
//
//  Created by Максим on 14.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit


    private func setupGridLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(section: createSection())
        return layout
    }
    
    private func createSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: createGroup())
        return section
    }
    
    private func createGroup() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.4))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [createItem()])
        return groupLayout
    }
    
    private func createItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        return itemLayout
    }


/*
    private func setupLineLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(section: createLineSection())
        return layout
    }
    
    private func createLineSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: createLineGroup())
        return section
    }
    
    private func createLineGroup() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.4))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [createLineItem()])
        return groupLayout
    }
    
    private func createLineItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6)
        return itemLayout
    }
*/

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private func setupNavigationControllers() -> [UIViewController] {
        let noteBoardsNavigationController = UINavigationController(rootViewController: NoteBoardsViewController(collectionViewLayout: setupGridLayout()))
        noteBoardsNavigationController.tabBarItem = UITabBarItem(title: "Notes", image: UIImage(systemName: "pencil.tip.crop.circle"), selectedImage: nil)
        
        let taskBoardsNavigationController = UINavigationController(rootViewController: TaskBoardsViewController())
        taskBoardsNavigationController.tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "rectangle.stack.fill"), selectedImage: nil)
        
        let favoritesNavigationController = UINavigationController(rootViewController: FavoritesViewController())
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), selectedImage: nil)
        
        let settingsNavigationController = UINavigationController(rootViewController: SettingsViewController())
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: nil)
        
        return [noteBoardsNavigationController, taskBoardsNavigationController, favoritesNavigationController, settingsNavigationController]
    }
    
    private func setupTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.backgroundColor = #colorLiteral(red: 0.1046186015, green: 0.1221224591, blue: 0.1803921569, alpha: 1)
        tabBarController.setViewControllers(setupNavigationControllers(), animated: true)
        return tabBarController
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.rootViewController = setupTabBar()
        window?.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.137254902, blue: 0.1568627451, alpha: 1)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
