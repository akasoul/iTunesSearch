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
    
    var showCollection=true
    let model=Model()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.albums.count
        return self.model.albums.count
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
//        if(self.artworks[indexPath.item] != nil){
//            cell.data=CustomData(title: self.albums[indexPath.item], url: "dsds", backgroundImage: self.artworks[indexPath.item]!)
//        }
        if(self.model.albums[indexPath.item].cover != nil){
            cell.data=CustomData(title: self.model.albums[indexPath.item].name, url: "", backgroundImage: self.model.albums[indexPath.item].cover!)
        }
        return cell
    }
    
    

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func showPopup(index: Int){
        
        let rootVC=AlbumInfoController()
        rootVC.title="test title"
        let navVC=UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .popover
        navVC.modalTransitionStyle = .coverVertical
        navVC.view.frame=CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height*0.5)
        rootVC.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "fwd")
        rootVC.album=self.model.albums[index]
        present(navVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("selected at: ")
        print(indexPath.first)
        print(indexPath.last)
        print(indexPath.row)
        self.model.newAlbumRequest(item: indexPath.item)
        self.showPopup(index: indexPath.item)
        //(self.parent as! tabController).showPopup()
        //self.showDetailViewController(self.info, sender: nil)
//        let newvc=UIViewController()
//        newvc.view=UIView(frame: self.view.frame)
//        newvc.view.backgroundColor = .yellow
//        newvc.navigationController?.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "back")
//        self.pushViewController(newvc, animated: true)
        
//
//        let rootVC=testViewController()
//        rootVC.title="test title"
//        let navVC=UINavigationController(rootViewController: rootVC)
//        //navVC.view=UIView()
//        //navVC.view.backgroundColor = .purple
//        navVC.modalPresentationStyle = .fullScreen
//        rootVC.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "back")
//        present(navVC, animated: true)
        
        //self.showCollection=false
        //self.viewDidLoad()
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate=self
        self.searchBar.frame=CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height*0.2)
        self.view.addSubview(self.searchBar)

        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        
        let tabBarHeight=(parent as! UITabBarController).tabBar.frame.height

        let collectionFrame=CGRect(x: 0, y: self.view.frame.height*0.2, width: self.view.frame.width, height: self.view.frame.height*0.8-tabBarHeight)
        
        
        let collectionView=UICollectionView(frame: .zero, collectionViewLayout: layout)
        let customCellNib=UINib(nibName: "CustomCell2", bundle: .main)
        collectionView.register(customCellNib, forCellWithReuseIdentifier: "cell")
        collectionView.frame=collectionFrame
        collectionView.isScrollEnabled=true
        collectionView.scrollIndicatorInsets = .zero
        collectionView.showsHorizontalScrollIndicator=true
        collectionView.isPagingEnabled=true
        collectionView.contentInset = .zero
        collectionView.delegate=self
        collectionView.dataSource=self
        collectionView.backgroundColor=UIColor.lightGray
        view.addSubview(collectionView)
    }
    
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(self.searchBar.text != nil){
            self.model.newRequest(input: self.searchBar.text!)
        }
        self.viewDidLoad()
    }
    /*
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(self.searchBar.text != nil){
            
            self.model.newRequest(input: self.searchBar.text!)
            var path = "https://itunes.apple.com/search?term="
            (parent as! tabController).hst.arr.append(self.searchBar.text!)
            path.append(self.searchBar.text!.replacingOccurrences(of: " ", with: "%20"))
            path.append("&entity=song&country=ru&limit=1000")
            let url = URL(string: path)!
            var answer=""
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                answer=(String(data: data, encoding: .utf8)!)
                do{
                    self.response = try JSONDecoder().decode(jsonStruct.self, from: answer.data(using: .utf8)!)
                }
                catch{
                    print(error)
                }
            }
            
            task.resume()
            while !task.progress.isFinished{
                sleep(1)
            }
            var imgLinks=[String]()
            for i in 0..<self.response!.results.count{
                if(self.response!.results[i].collectionName != nil && self.response!.results[i].artworkUrl100 != nil){
                    var append=true
                    for j in 0..<self.albums.count{
                        if(self.albums[j]==self.response!.results[i].collectionName){
                            append=false
                        }
                    }
                    if(append){
                        self.albums.append(self.response!.results[i].collectionName!)
                        self.albumsId.append(self.response!.results[i].collectionId!)
                        imgLinks.append(self.response!.results[i].artworkUrl100!)
                        
                    }
                }
            }
            
            var albumPath="https://itunes.apple.com/lookup?id="
            albumPath+=String(self.albumsId[0])
            let albumURL=URL(string: albumPath)!
            let task2 = URLSession.shared.dataTask(with: albumURL) {(data, response, error) in
                guard let data = data else { return }
                answer=(String(data: data, encoding: .utf8)!)
                do{
                    self.response = try JSONDecoder().decode(jsonStruct.self, from: answer.data(using: .utf8)!)
                }
                catch{
                    print(error)
                }
            }
            
            task2.resume()
            while !task2.progress.isFinished{
                sleep(1)
            }
            
            self.artworks=[UIImage?].init(repeating: nil, count: self.albums.count)
            
            let group=DispatchGroup()
            group.enter()
            
            for i in 0..<self.artworks.count{
                DispatchQueue.global().async{
                    let url=URL(string: imgLinks[i])!
                    var img: UIImage?
                    var imgData: Data?
                    do{
                    imgData = try Data(contentsOf: url)
                    }
                    catch{
                    }
                    if(imgData != nil){
                        img=UIImage(data: imgData!)
                    }
                    self.artworks[i]=img
                    print("exit thread")
                    DispatchQueue.main.sync{
                    self.view.endEditing(true)
                    self.viewDidLoad()
                    }
                }
            }
            
        }
    }
    */
 }
