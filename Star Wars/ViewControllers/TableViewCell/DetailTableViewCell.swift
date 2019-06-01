//
//  DetailTableViewCell.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 31/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var stringArray: [String] = []
    var arrayType = -1 // 0 -> Homeworld; 1 -> Films ; 2 -> Species; 3 -> Vehicles; 4 -> Starships
    var bgColorForCollectionViewCell = UIColor.white
    var bgColorForCollectionViewCellLabel = UIColor.black
    var delegate: CollectionViewCellSelectionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewID")
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stringArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.performClickOnCVCell(arrayType: self.arrayType, index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath as IndexPath) as! DetailCollectionViewCell
        
        cell.lblCollectionViewCell.text = stringArray[indexPath.row]
        cell.lblCollectionViewCell.textColor = bgColorForCollectionViewCellLabel
        cell.collectionViewCellView.backgroundColor = bgColorForCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize = stringArray[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24.0)])
        print(size)
        return CGSize(width: size.width + 44, height: 30)
    }
    
}

protocol CollectionViewCellSelectionDelegate {
    func performClickOnCVCell(arrayType: Int, index: Int)
}
