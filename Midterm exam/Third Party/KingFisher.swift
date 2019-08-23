//
//  KingFisher.swift
//  Midterm exam
//
//  Created by 潘立祥 on 2019/8/23.
//  Copyright © 2019 PanLiHsiang. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

func setupImage(_ urlString: String?) {
    
    guard urlString != nil else { return }
    
    let url = URL(string: urlString!)
    
    self.kf.setImage(with: url)
    
    }
}
