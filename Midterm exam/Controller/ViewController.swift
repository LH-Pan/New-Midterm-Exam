//
//  ViewController.swift
//  Midterm exam
//
//  Created by 潘立祥 on 2019/8/23.
//  Copyright © 2019 PanLiHsiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
  
    var myImageView = UIImageView()
    
    var summary: Int = 0
    
    var fetchMusicInfo: [Album] = []
    
    var datas: [Bool] = {
        
        var array: [Bool] = []
        
        for music in 0...1000 {
            
            array.append(false)
        }
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        MusicInfoProvider.shared.musicInfoDelegate = self
        
        MusicInfoProvider.shared.loadItem()
    }
    
    func setupTableView() {
        
        loadViewIfNeeded()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        let headerXib = UINib(nibName: MyTableViewHeaderView.identifier, bundle: nil)
        
        tableView.register(headerXib, forHeaderFooterViewReuseIdentifier: MyTableViewHeaderView.identifier)
        
        tableView.registerCellWithNib(identifier: MyTableViewCell.identifier, bundle: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchMusicInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier,
                                                 for: indexPath)
        
        guard let songCell = cell as? MyTableViewCell else { return cell }
        
        songCell.songTitle.text = fetchMusicInfo[indexPath.row].name
        
        songCell.songImage.setupImage(fetchMusicInfo[indexPath.row].album.images[indexPath.section].url)
        
        songCell.myViewController = self
        
        if indexPath.row == fetchMusicInfo.count - 1 {
            if summary > fetchMusicInfo.count {
                MusicInfoProvider.shared.loadItem()
            }
        }
        
        if datas[indexPath.row] {
            
            songCell.likeButton.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            
            songCell.likeButton.isSelected = true
        } else {
            
            songCell.likeButton.setImage(#imageLiteral(resourceName: "like(white)"), for: .normal)
            
            songCell.likeButton.isSelected = false
        }
        
        return songCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        myImageView.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: 600)
        
        myImageView.backgroundColor = .white
        
        myImageView.setupImage("https://i.kfs.io/playlist/global/26541395v266/cropresize/600x600.jpg")
        
        myImageView.contentMode = .scaleAspectFill
        
        return myImageView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
    
    func didClickLikeInCell(_ cell: MyTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        guard let targetCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        guard let myCell = targetCell as? MyTableViewCell else {
            return
        }

        myCell.likeButton.isSelected = !myCell.likeButton.isSelected
        
        if myCell.likeButton.isSelected {
            
            datas[indexPath.row] = true
            
            myCell.likeButton.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            
        } else {
            
            datas[indexPath.row] = false
            
            myCell.likeButton.setImage(#imageLiteral(resourceName: "like(white)"), for: .normal)
        }
    }
}

extension ViewController: PassMusicInfoDelegate {
    
    func provider(didGet musicSummary: Int) {
        summary = musicSummary
    }
    
    func provider(didGet musicInfo: [Album]) {
        
        fetchMusicInfo = musicInfo
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
}
