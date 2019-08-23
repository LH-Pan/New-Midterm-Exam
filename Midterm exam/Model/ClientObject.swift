//
//  ClientObject.swift
//  Midterm exam
//
//  Created by 潘立祥 on 2019/8/23.
//  Copyright © 2019 PanLiHsiang. All rights reserved.
//

import Foundation

struct MusicData: Codable {
    
    let data: [Album]
    
    let summary: Total
}

struct Total: Codable {
    
    let total: Int
}

struct Album: Codable {
    
    let name: String
    
    let album: Info
}

struct Info: Codable {
    
    let name: String
    
    let images: [Image]
    
}

struct Image: Codable {
    
    let height: Int
    
    let width: Int
    
    let url: String
}
