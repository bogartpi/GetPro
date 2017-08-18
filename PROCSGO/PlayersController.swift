//
//  PlayersController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 24/07/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class PlayersController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var team: Team? {
        didSet {
            if let teamName = team?.name {
                navigationItem.title = teamName
            }
        }
    }

    
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = customGrayColor
        collectionView?.isUserInteractionEnabled = true
        collectionView?.register(PlayerCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        changeNavigationTintColor(customWhitecolor)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 20)!]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = team?.players?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PlayerCell
        if let player = team?.players?[indexPath.item] {
            cell.player = player
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 28, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let detailsController = DetailsController(collectionViewLayout: layout)
        detailsController.player = team?.players?[indexPath.item]
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
}


