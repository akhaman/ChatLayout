//
//  UICollectionView+.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(_ cells: [Cell.Type]) {
        cells.forEach { register($0, forCellWithReuseIdentifier: "\($0)") }
    }

    func register<Cell: UICollectionViewCell>(_ cells: Cell.Type...) {
        register(cells)
    }

    func dequeue<Cell: UICollectionViewCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withReuseIdentifier: "\(type)", for: indexPath) as! Cell
    }
}
