//
//  videoListTableViewCell.swift
//  XunLei
//
//  Created by abc on 2020/10/12.
//  Copyright © 2020 abc. All rights reserved.
//
//kingFisher的一般使用流程如下所示
import UIKit
import Kingfisher
typealias ButtonClick = (_ cell:videoListTableViewCell)->Void
typealias twoButtonClick = (_ name:String) ->Void
class videoListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        let url = URL(string:"http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg")
        self.videoImage.kf.setImage(with:url, placeholder:nil, options: .none, progressBlock: nil, completionHandler: nil)
        // Initialization code
    }
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoLableName: UILabel!
    @IBOutlet weak var videoPlayButton: UIButton!
    var oneBlock:ButtonClick!
    @IBAction func videoPlayButton(_ sender: Any) {
        if (self.oneBlock != nil) {
            self.oneBlock(self)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
