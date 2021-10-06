//
//  UICollectionViewCell+.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 06.10.2021.
//

import UIKit

extension UICollectionViewCell {

    func addSeparator() {
        let separatorView = UIView()
        separatorView.backgroundColor = .separator

        contentView.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
