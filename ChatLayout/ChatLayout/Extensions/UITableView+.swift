//
//  UITableView+.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 07.09.2021.
//

import UIKit

extension UITableView {
    func register(_ cells: [UITableViewCell.Type]) {
        cells.forEach { register($0, forCellReuseIdentifier: "\($0)") }
    }

    func register(_ cells: UITableViewCell.Type...) {
        register(cells)
    }

    func dequeue<Cell: UITableViewCell>(_ type: Cell.Type) -> Cell {
        dequeueReusableCell(withIdentifier: "\(type)") as! Cell
    }
}
