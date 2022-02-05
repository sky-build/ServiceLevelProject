//
//  HomeTabBarController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/27.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    var homeNavigationController : UINavigationController!
    var shopNavigationController : UINavigationController!
    var friendsNavigationController : UINavigationController!
    var myInfoNavigationControoller : UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserViewModel().userAPI.getUser()
        
        // 탭바 설정
        setTabBar()
    }
    
    // 탭바 설정
    private func setTabBar() {
        view.backgroundColor = .white
        
        homeNavigationController = UINavigationController(rootViewController: MainViewController())
        shopNavigationController = UINavigationController(rootViewController: ShopViewController())
        friendsNavigationController = UINavigationController(rootViewController: FriendsViewController())
        myInfoNavigationControoller = UINavigationController(rootViewController: MyInfoViewController())
        
        self.viewControllers = [homeNavigationController, shopNavigationController, friendsNavigationController, myInfoNavigationControoller]

        homeNavigationController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home.inact"), selectedImage: nil)
        shopNavigationController.tabBarItem = UITabBarItem(title: "새싹샵", image: UIImage(named: "shop.inact"), selectedImage: nil)
        friendsNavigationController.tabBarItem = UITabBarItem(title: "친구", image: UIImage(named: "friends.inact"), selectedImage: nil)
        myInfoNavigationControoller.tabBarItem = UITabBarItem(title: "내정보", image: UIImage(named: "my.inact"), selectedImage: nil)
        
        // 탭바 나타나는 색상 설정
        UITabBar.appearance().tintColor = .slpGreen
    }
    
    
}
