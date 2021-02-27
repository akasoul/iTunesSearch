//
//  Model.swift
//  iTunes search
//
//  Created by Anton Voloshuk on 27.01.2021.
//

import Foundation
import UIKit
import Combine


struct jsonStruct: Encodable,Decodable {
    struct Result: Encodable, Decodable {
        let wrapperType: String?
        let kind: String?
        let artistId, collectionId, trackId: Int?
        let artistName: String?
        let collectionName, trackName, collectionCensoredName, trackCensoredName: String?
        let artistViewUrl, collectionViewUrl, trackViewUrl: String?
        let previewUrl: String?
        let artworkUrl30, artworkUrl60, artworkUrl100: String?
        let collectionPrice, trackPrice: Double?
        let releaseDate: String?
        let discCount, discNumber, trackCount, trackNumber: Int?
        let trackTimeMillis: Int?
        let country: String?
        let currency: String?
        let primaryGenreName: String?
    }
    let resultCount: Int
    let results: [Result]
}

struct album{
    struct song{
        let name:String
        let length: Int
    }
    let name: String
    let cover: UIImage?
    let id: Int
    var songs: [song]?
    let genre: String
    let releaseDate: String
    

}

class Model{
    var response: jsonStruct?
    var albums: [album]=[]

    var searchHistory: [String]=[]{
        didSet{
            UserDefaults.standard.setValue(self.searchHistory, forKey: "searchHistory")
        }
    }

    var work: DispatchWorkItem?
    init(){
        let tmp=UserDefaults.standard.value(forKey: "searchHistory") as! [String]?
        if(tmp != nil){
            self.searchHistory=tmp!
        }
    }
    func newAlbumRequest(item: Int){
        if item>=self.albums.count{
            return
        }
        if self.albums[item].songs != nil{
            return
        }
        print("new search")
        var albumsResponse: jsonStruct?
        var path = "https://itunes.apple.com/search?term="
        path.append(self.albums[item].name.replacingOccurrences(of: " ", with: "%20"))
        path.append("&entity=song")
        let albumURL = URL(string: path)
        if(albumURL != nil){
            var answer=""
            let task = URLSession.shared.dataTask(with: albumURL!) {(data, response, error) in
                guard let data = data else { return }
                answer=(String(data: data, encoding: .utf8)!)
                do{
                    albumsResponse = try JSONDecoder().decode(jsonStruct.self, from: answer.data(using: .utf8)!)
                }
                catch{
                    albumsResponse = nil
                }
            }
            
            task.resume()
            while !task.progress.isFinished{
                sleep(1)
            }
            
            if(albumsResponse != nil){
                var songs: [album.song]=[]
                for j in 0..<albumsResponse!.results.count{
                    if(albumsResponse!.results[j].collectionId != nil){
                        if(albumsResponse!.results[j].collectionId! == self.albums[item].id){
                            if(albumsResponse!.results[j].trackName != nil && albumsResponse!.results[j].trackTimeMillis != nil){
                                songs.append(album.song(name: albumsResponse!.results[j].trackName!, length: albumsResponse!.results[j].trackTimeMillis!))
                            }
                        }
                    }
                }
                print(songs)
                self.albums[item].songs=songs
            }
        }
    }
    func newRequest(input: String){
        if(self.work != nil){
            self.work!.cancel()
        }
        self.work=DispatchWorkItem(block: { self.newRequestTask(input: input) })
        self.work!.perform()
    }
    func newRequestTask(input: String){
        if input==""{
            return
        }
        self.searchHistory.append(input)
        self.albums=[]

        
        DispatchQueue.global().sync{
            var path = "https://itunes.apple.com/search?term="
            path.append(input.replacingOccurrences(of: " ", with: "%20"))
            path.append("&entity=album&limit=1000")
            let url = URL(string: path)!
            var answer=""
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                answer=(String(data: data, encoding: .utf8)!)
                do{
                    self.response = try JSONDecoder().decode(jsonStruct.self, from: answer.data(using: .utf8)!)
                }
                catch{
                    return
                }
            }
            
            task.resume()
            while !task.progress.isFinished{
                sleep(1)
            }
            
            for i in 0..<self.response!.results.count{
                var addNew=true
                for j in 0..<self.albums.count{
                    if(self.response!.results[i].collectionId==self.albums[j].id){
                        addNew=false
                        break
                    }
                }
                if(addNew){
                    if(self.response!.results[i].collectionName != nil && self.response!.results[i].artworkUrl100 != nil && self.response!.results[i].collectionId != nil){
                        let imgURL=URL(string: self.response!.results[i].artworkUrl100!)
                        var img: UIImage?
                        var imgData: Data?
                        if(imgURL != nil){
                            do{
                                imgData = try Data(contentsOf: imgURL!)
                            }
                            catch{
                            }
                            if(imgData != nil){
                                img=UIImage(data: imgData!)
                            }
                            
                            self.albums.append(album(name: self.response!.results[i].collectionName!, cover: img, id: self.response!.results[i].collectionId!, songs: nil, genre: self.response!.results[i].primaryGenreName!,releaseDate: self.response!.results[i].releaseDate!))
                        }
                    }
                }
            }
            
            DispatchQueue.global().async{
                for i in 0..<self.albums.count{
                    if(i<self.albums.count){
                    if(self.albums[i].songs != nil){
                        print("Album: ",self.albums[i].name,".Songs were found")
                        continue
                    }
                    var albumsResponse: jsonStruct?
                    var path = "https://itunes.apple.com/search?term="
                    path.append(self.albums[i].name.replacingOccurrences(of: " ", with: "%20"))
                    path.append("&entity=song")
                    let albumURL = URL(string: path)
                    if(albumURL != nil){
                        var answer=""
                        let task = URLSession.shared.dataTask(with: albumURL!) {(data, response, error) in
                            guard let data = data else { return }
                            answer=(String(data: data, encoding: .utf8)!)
                            do{
                                albumsResponse = try JSONDecoder().decode(jsonStruct.self, from: answer.data(using: .utf8)!)
                            }
                            catch{
                                albumsResponse = nil
                            }
                        }
                        
                        task.resume()
                        while !task.progress.isFinished{
                            sleep(1)
                        }
                        
                        if(albumsResponse != nil){
                            var songs: [album.song]=[]
                            for j in 0..<albumsResponse!.results.count{
                                if(albumsResponse!.results[j].collectionId != nil && i<self.albums.count){
                                    if(albumsResponse!.results[j].collectionId! == self.albums[i].id){
                                        if(albumsResponse!.results[j].trackName != nil && albumsResponse!.results[j].trackTimeMillis != nil){
                                            songs.append(album.song(name: albumsResponse!.results[j].trackName!, length: albumsResponse!.results[j].trackTimeMillis!))
                                        }
                                    }
                                }
                            }
                            if(self.searchHistory.last == input){
                                if(i<self.albums.count){
                                self.albums[i].songs=songs
                                }
                            }
                        }
                    }
                }
            }
            }
            
        }
        
    }
}
