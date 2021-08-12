//
//  FLCRDashbaordView+CollectionView.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 06/08/21.
//

import UIKit

/// Extension of FLCRDashboardView to hold UICollectionViewDataSource functoins
extension FLCRDashboardView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.photos?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifire, for: indexPath) as? FLCRDashboardCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = self.photos?.items[indexPath.item]
        cell.configureCell(with: item)
        return cell
    }
    
}

/// Extension of FLCRDashboardView to hold UICollectionViewDelegate functoins
extension FLCRDashboardView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectItem(at: indexPath.item, photos: self.photos)
    }
    
}

/// Extension of FLCRDashboardView to hold UICollectionViewDelegateFlowLayout functoins
extension FLCRDashboardView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let mainScreenWidth = UIScreen.main.bounds.size.width
        let numberOfItems: CGFloat = 3
        let gapping = (numberOfItems + 1) * 10
        let width = (mainScreenWidth - gapping) / numberOfItems
        let size = CGSize(width: width, height: width)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}
