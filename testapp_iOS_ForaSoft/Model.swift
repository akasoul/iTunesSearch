//
//  Model.swift
//  testapp_iOS_ForaSoft
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
    
    static var placeholder: Self{
        return album(name: "", cover: nil, id: 0, songs: nil)
    }
}

class Model{
    var response: jsonStruct?
    var albums: [album]=[]
    var artworks:[UIImage?]=[]
    var albumsId:[Int]=[]
    
    func newAlbumRequest(item: Int){
        if item>=self.albums.count{
            return
        }
        if self.albums[item].songs != nil{
            return
        }
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
        if input==""{
            return
        }
        self.albums=[]
        self.artworks=[]
        self.albumsId=[]
        DispatchQueue.global().sync {
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
                            
                            self.albums.append(album(name: self.response!.results[i].collectionName!, cover: img, id: self.response!.results[i].collectionId!, songs: nil))
                        }
                    }
                }
            }
            
            DispatchQueue.global().async{
                for i in 0..<self.albums.count{
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
                                if(albumsResponse!.results[j].collectionId != nil){
                                    if(albumsResponse!.results[j].collectionId! == self.albums[i].id){
                                        if(albumsResponse!.results[j].trackName != nil && albumsResponse!.results[j].trackTimeMillis != nil){
                                            songs.append(album.song(name: albumsResponse!.results[j].trackName!, length: albumsResponse!.results[j].trackTimeMillis!))
                                        }
                                    }
                                }
                            }
                            self.albums[i].songs=songs
                        }
                    }
                }
            }
            
        }
        
    }
}
