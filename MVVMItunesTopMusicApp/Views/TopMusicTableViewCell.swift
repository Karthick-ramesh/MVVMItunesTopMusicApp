//
//  TopMusicTableViewCell.swift
//  MVVMItunesMusic
//
//  Created by karthick  Ramesh on 30/05/18.
//  Copyright © 2018 karthick  Ramesh. All rights reserved.
//

import UIKit
import Kingfisher

class TopMusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverArtImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func config(viewModelPresentable:TopMusicItemViewModel){
        titleLbl.text = viewModelPresentable.musicTitle ?? ""
        nameLbl.text = viewModelPresentable.musicName ?? ""
        coverArtImage.kf.setImage(with: viewModelPresentable.coverArtImageUrl)
        
    }
    
}
