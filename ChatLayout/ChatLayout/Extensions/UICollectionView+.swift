//
//  UICollectionView+.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

extension UICollectionView {
    func register(_ cells: [UICollectionViewCell.Type]) {
        cells.forEach { register($0, forCellWithReuseIdentifier: "\($0)") }
    }

    func register(_ cells: UICollectionViewCell.Type...) {
        register(cells)
    }

    func dequeue<Cell: UICollectionViewCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withReuseIdentifier: "\(type)", for: indexPath) as! Cell
    }

    func register(_ reusableView: UICollectionReusableView.Type, withKind kind: String) {
        register(reusableView, forSupplementaryViewOfKind: kind, withReuseIdentifier: "\(reusableView)")
    }

    func dequeue<View: UICollectionReusableView>(_ type: View.Type, ofKind kind: String, indexPath: IndexPath) -> View {
        dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(type)", for: indexPath) as! View
    }
}
