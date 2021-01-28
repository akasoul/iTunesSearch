//
//  FirstTabController.swift
//  testapp_iOS_ForaSoft
//
//  Created by Anton Voloshuk on 28.01.2021.
//

import Foundation
import UIKit


class firstTabController: UINavigationController,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    let info = AlbumInfoController()
    let searchBar=UISearchBar()
    let collectionViewLayout=UICollectionViewLayout()
    var collectionView: UICollectionView?
    var showCollection=true
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.parent as! tabController).model.albums.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 50, left: 50, bottom: 50, right: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell2

        if((self.parent as! tabController).model.albums[indexPath.item].cover != nil){
            cell.data=CustomData(title: (self.parent as! tabController).model.albums[indexPath.item].name, url: "", backgroundImage: (self.parent as! tabController).model.albums[indexPath.item].cover!)
        }
        return cell
    }
    
    

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=self.collectionView!.cellForItem(at: indexPath) as! CustomCell2
  print(cell.data!.title)
        (self.parent as! tabController).model.newAlbumRequest(item: indexPath.item)
        self.showPopup(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func showPopup(index: Int){
        
        let rootVC=PopUpVC()//nibName: "PopUpVC", bundle: nil)//AlbumInfoController()
        let bundle=Bundle(for: type(of: rootVC))
        bundle.loadNibNamed("PopUpVC", owner: rootVC, options: nil)
        
        rootVC.album=(self.parent as! tabController).model.albums[index]
        present(rootVC, animated: true)
    }
    

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate=self
        self.searchBar.frame=CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height*0.2)
        self.view.addSubview(self.searchBar)

        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .vertical
        
        let tabBarHeight=(parent as! UITabBarController).tabBar.frame.height

        let collectionFrame=CGRect(x: 0, y: self.view.frame.height*0.2, width: self.view.frame.width, height: self.view.frame.height*0.8-tabBarHeight)
        
        
        self.collectionView=UICollectionView(frame: .zero, collectionViewLayout: layout)
        let customCellNib=UINib(nibName: "CustomCell2", bundle: .main)
        self.collectionView!.register(customCellNib, forCellWithReuseIdentifier: "cell")
        self.collectionView!.frame=collectionFrame
        self.collectionView!.isScrollEnabled=true
        self.collectionView!.scrollIndicatorInsets = .zero
        self.collectionView!.showsHorizontalScrollIndicator=true
        self.collectionView!.isPagingEnabled=true
        self.collectionView!.contentInset = .zero
        self.collectionView!.delegate=self
        self.collectionView!.dataSource=self
        self.collectionView!.backgroundColor=UIColor.lightGray
        view.addSubview(self.collectionView!)
    }
    
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(self.searchBar.text != nil){
            (self.parent as! tabController).model.newRequest(input: self.searchBar.text!)
        }
        self.viewDidLoad()
    }
    
 }
