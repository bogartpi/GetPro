//
//  DetailsController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 26/07/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

private let cellId = "cellId"
private let gearCellId = "gearCellId"
private let configCellId = "configCellId"

class DetailsController: UICollectionViewController, DetailsHandlerProtocol {
    
    var player: Player? {
        didSet {
            if let alias = player?.alias {
                navigationItem.title = alias
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.customGrayColor
        collectionView?.register(ScreenshotsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(GearCell.self, forCellWithReuseIdentifier: gearCellId)
        collectionView?.register(ConfPovCell.self, forCellWithReuseIdentifier: configCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.customWhitecolor
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 20)!]
    }
    
    func handleConfigController() {
        let layout = UICollectionViewFlowLayout()
        let cfgController = ConfigController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: cfgController)
        cfgController.config = player?.info?.cfg
        present(navController, animated: true, completion: nil)
    }
    
    func handlePovsController() {
        let layout = UICollectionViewFlowLayout()
        let povVC = PovController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: povVC)
        povVC.povs = player?.info?.povs
        present(navController, animated: true, completion: nil)
    }

}

extension DetailsController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configCellId, for: indexPath) as! ConfPovCell
            cell.myDelegate = self
            return cell
            
        } else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gearCellId, for: indexPath) as! GearCell
            cell.gearInfo = player?.info
            return cell
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)  as! ScreenshotsCell
        cell.info = player?.info
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1  {
            return CGSize(width: view.frame.width, height: 40)
        }
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
}
