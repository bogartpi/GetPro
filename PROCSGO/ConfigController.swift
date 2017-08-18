//
//  ConfigController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 27/07/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ConfigController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var config: Config?
    
    private let headerId = "headerId"
    private let cellId = "cellId"
    
    private let sectionNames = ["Mouse Settings", "Monitor Settings", "Crosshair Settings"]
    private let mouseSettingsTitles = ["EDPI", "Mouse DPI", "Mouse Hz", "Windows Sensitivity", "Sensitivity", "Zoom Sensitivity"]
    private let monitorSettingsTitles = ["Resolution", "Aspect Ratio", "Aspect Ratio Description", "Monitor Hz"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Config"
        collectionView?.backgroundColor = customGrayColor
        collectionView?.register(ConfigCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier:  headerId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        customizeNavController()
        
        setupNavigationButtons()
    }
    
    private func setupNavigationButtons() {
        let backImage = UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal)
        let backButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(dismissController))
        navigationItem.leftBarButtonItems = [backButtonItem]
    }
    
    func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func customizeNavController() {
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 2
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = customRedColor
        navigationController?.navigationBar.tintColor = customWhitecolor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: customWhitecolor, NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 20)!]
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! Header
        header.sectionNamelabel.text = sectionNames[indexPath.section]
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ConfigCell
        let sect = indexPath.section
        if sect == 0 {
            cell.titleLabel.text = mouseSettingsTitles[indexPath.item]
            cell.valueLabel.text = config?.mouseSettings?[indexPath.item]
        } else if sect == 1 {
            cell.titleLabel.text = monitorSettingsTitles[indexPath.item]
            cell.valueLabel.text = config?.monitorSettings?[indexPath.item]
        } else if sect == 2 {
            cell.titleLabel.text = ""
            cell.valueLabel.text = config?.crosshaircfg?[indexPath.item]
        }
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if let mouseCount = config?.mouseSettings?.count {
                return mouseCount
            }
        case 1:
            if let monitorCount = config?.monitorSettings?.count {
                return monitorCount
            }
        case 2:
            if let crossCount = config?.crosshaircfg?.count {
                return crossCount
            }
        default:
            print("Wrong section")
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 28, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }

}
