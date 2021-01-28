//
//  MainController.swift
//  testapp3_iOS
//
//  Created by User on 22.01.2021.
//

import Foundation
import UIKit

class historyTmp{
    var arr=[String](){
        didSet{
            print(self.arr)
        }
    }
}

class tabController: UITabBarController,UITabBarControllerDelegate{
    let firstTabView=firstTabController()
    let secondTabView=secondTabController()
    let hst=historyTmp()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self
        
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.firstTabView.tabBarItem=UITabBarItem(tabBarSystemItem: .search, tag: 0)
        self.secondTabView.tabBarItem=UITabBarItem(tabBarSystemItem: .history, tag: 1)
        self.viewControllers=[self.firstTabView,self.secondTabView]
        self.view.backgroundColor=UIColor.white
    }
}










class infoViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view=UIView(frame: .zero)
        self.view.backgroundColor = .orange
            let navVC=UINavigationController(rootViewController: self)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "back")
        self.view.addSubview(navVC.view)
    }
}



class popupView: UIView {
  
     override init(frame: CGRect)   {
         super.init(frame: frame)
        self.backgroundColor = .orange
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
