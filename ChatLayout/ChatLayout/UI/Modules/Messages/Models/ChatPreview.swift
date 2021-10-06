//
//  ChatPreview.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 06.10.2021.
//

import UIKit

struct ChatPreview: Hashable {
    let id: String
    let firstName: String
    let lastName: String
    let image: UIImage
    let message: String
    let date: String

    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
