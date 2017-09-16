//
//  NewsDetailController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 29/08/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class NewsDetailController: UICollectionViewController {

    var post: Post?
    let cellId = "cellId"
    let bodyCellId = "bodyCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.customGrayColor
        customizeNavController()
        collectionView?.register(NewsDetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(BodyTextCell.self, forCellWithReuseIdentifier: bodyCellId)
    }
    
    fileprivate func descriptionAttributedText() -> NSAttributedString {
        var attributedText = NSMutableAttributedString()
        if let desc = post?.descriptionText {
            attributedText = NSMutableAttributedString(string: desc,
                                                       attributes: [NSForegroundColorAttributeName: UIColor.customWhitecolor,
                                                                    NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        }
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        
        let range = NSMakeRange(0, attributedText.string.characters.count)
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        
        return attributedText
    }
}

extension NewsDetailController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsDetailCell
            cell.post = post
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bodyCellId, for: indexPath) as! BodyTextCell
        cell.bodyLabel.attributedText = descriptionAttributedText()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            let maxSize = CGSize(width: view.frame.width, height: 2800)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: maxSize, options: options, context: nil)
            return CGSize(width: view.frame.width - 16, height: rect.height + 100)
        }
        return CGSize(width: view.frame.width - 16, height: 320)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
}
