//
//  TokenProvider.swift
//  Midterm exam
//
//  Created by 潘立祥 on 2019/8/23.
//  Copyright © 2019 PanLiHsiang. All rights reserved.
//

import UIKit

protocol PassMusicInfoDelegate: AnyObject {
    
    func provider(didGet musicInfo: [Album])
    
    func provider(didGet musicSummary: Int)
}

class MusicInfoProvider {
    
    weak var musicInfoDelegate: PassMusicInfoDelegate?
    
    static let shared = MusicInfoProvider()
    
    var limit: Int = 0
    
    func loadItem() {
        limit += 20
        fetchMusicData(addLimit: limit)
    }
    
    func fetchMusicData(addLimit: Int) {
        
        let urlString = "https://api.kkbox.com/v1.1/new-hits-playlists/DZrC8m29ciOFY2JAm3/tracks?territory=TW&limit=\(limit)"
        
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = ["Accept": "application/json",
                                       "Content-Type": "application/x-www-form-urlencoded",
                                       "Authorization": "Bearer 8tCiSQfikM1Y3NVLAlFDzQ=="]
        
        URLSession.shared.dataTask(
        with: request) {(data, response, error) in
            
            guard error == nil else {
                
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            
            let statusCode = httpResponse.statusCode
            
            print (statusCode)
            if statusCode >= 200 && statusCode < 300 {
                
                guard let data = data else { return }
                
                let decoder = JSONDecoder()
                
                do {
                    let musicData = try decoder.decode(MusicData.self, from: data)
                    
                    let musicInfo = musicData.data
                    
                    let musicSummary = musicData.summary.total
                    
                    self.musicInfoDelegate?.provider(didGet: musicInfo)
                    self.musicInfoDelegate?.provider(didGet: musicSummary)
                    print(musicInfo)
                    print(musicData.summary)
                    
                } catch {
                    print(error)
                }
            }
            
            if statusCode >= 400 && statusCode < 500 {
                
                print("Client error")
            }
            }.resume()
    }
}
