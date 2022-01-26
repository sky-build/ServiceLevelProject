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
        
        view.backgroundColor = .white
        
        homeNavigationController = UINavigationController(rootViewController: MainViewController())
        shopNavigationController = UINavigationController(rootViewController: ShopViewController())
        friendsNavigationController = UINavigationController(rootViewController: FriendsViewController())
        myInfoNavigationControoller = UINavigationController(rootViewController: MyInfoViewController())
        
        self.viewControllers = [homeNavigationController, shopNavigationController, friendsNavigationController, myInfoNavigationControoller]

        homeNavigationController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home.inact"), selectedImage: UIImage(named: "home.act"))
        shopNavigationController.tabBarItem = UITabBarItem(title: "새싹샵", image: UIImage(named: "shop.inact"), selectedImage: UIImage(named: "shop.act"))
        friendsNavigationController.tabBarItem = UITabBarItem(title: "친구", image: UIImage(named: "friends.inact"), selectedImage: UIImage(named: "friends.act"))
        myInfoNavigationControoller.tabBarItem = UITabBarItem(title: "내정보", image: UIImage(named: "my.inact"), selectedImage: UIImage(named: "my.act"))
        
        // 이미지가 너무 커져셔 Inset설정
        homeNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        shopNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        friendsNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        myInfoNavigationControoller.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // 탭바 나타나는 색상 설정
        UITabBar.appearance().tintColor = .slpGreen

    }
    
}
