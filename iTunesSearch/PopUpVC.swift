//
//  PopUpVC.swift
//  iTunesSearch
//
//  Created by Anton Voloshuk on 28.01.2021.
//

import UIKit

class PopUpVC: UIViewController {
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var albumReleaseDate: UILabel!
    @IBOutlet weak var albumGenre: UILabel!
    @IBOutlet weak var albumName: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var albumSongs: UILabel!
    
    var album: album?{
        didSet{
            if(self.album != nil){
                self.albumName.text=self.album!.name
                self.albumCover.image=self.album!.cover
                self.albumGenre.text=self.album!.genre
                self.albumReleaseDate.text=self.album!.releaseDate
                self.albumSongs.text=""
                for i in 0..<self.album!.songs!.count{
                    let tmp = self.album!.songs![i].name + "\n"
                    self.albumSongs.text!.append(tmp)
                }
                
                

            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
