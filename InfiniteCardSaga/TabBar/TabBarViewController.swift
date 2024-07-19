//
//  TabBarViewController.swift
//  InfiniteCardSaga
//
//  Created by Владимир Кацап on 18.07.2024.
//

import UIKit

var postsArr = [Post]()

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        settings()
        loadPosts()
    }
    

    func settings() {
        
        tabBar.backgroundColor = UIColor(red: 23/255, green: 33/255, blue: 37/255, alpha: 1)
        let separatorView = UIView()
        separatorView.backgroundColor = .white.withAlphaComponent(0.1)
        tabBar.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.left.right.equalToSuperview()
        }
        
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.3)
        tabBar.tintColor = UIColor(red: 74/255, green: 112/255, blue: 208/255, alpha: 1)
        
        let gameVC = GameViewController()
        let gameItem = UITabBarItem(title: "Game", image: .tab1.resize(targetSize: CGSize(width: 24, height: 24)), tag: 0)
        gameVC.tabBarItem = gameItem
        
        let postsVC = PostsViewController()
        let postItem = UITabBarItem(title: "Posts", image: .tab2.resize(targetSize: CGSize(width: 24, height: 24)), tag: 1)
        postsVC.tabBarItem = postItem
        
        let comboVC = ComboViewController()
        let comboItem = UITabBarItem(title: "Combination", image: .tab3.resize(targetSize: CGSize(width: 24, height: 24)), tag: 1)
        comboVC.tabBarItem = comboItem
        
        viewControllers = [gameVC, postsVC, comboVC]
        
    }
    
    
    func loadPosts() {
        if let data = UserDefaults.standard.data(forKey: "postss") {
            do {
                let decoder = JSONDecoder()
                postsArr = try decoder.decode([Post].self, from: data)
            } catch {
                print("Ошибка при декодировании постов: \(error)")
            }
        }
    }

}
