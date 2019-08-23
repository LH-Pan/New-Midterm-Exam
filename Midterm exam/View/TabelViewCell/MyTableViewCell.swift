//
//  MyTableViewCell.swift
//  Midterm exam
//
//  Created by 潘立祥 on 2019/8/23.
//  Copyright © 2019 PanLiHsiang. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    weak var myViewController: ViewController?

    @IBOutlet weak var songImage: UIImageView!
    
    @IBOutlet weak var songTitle: UILabel!
    
    @IBOutlet weak var likeButton: UIButton! {
        
        didSet {
            likeButton.setImage(#imageLiteral(resourceName: "like(white)"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func likeAction(_ sender: UIButton) {
        
        myViewController?.didClickLikeInCell(self)
    }
}
