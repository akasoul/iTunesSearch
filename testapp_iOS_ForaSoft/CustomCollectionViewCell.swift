//
//  CustomCollectionViewCell.swift
//  testapp_iOS_ForaSoft
//
//  Created by User on 25.01.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func config(text: String){
        self.label.text=text
    }

}
