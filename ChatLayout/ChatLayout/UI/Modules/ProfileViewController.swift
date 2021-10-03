//
//  ProfileViewController.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 02.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = .zero
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        title = "Alex Tsimikas"
        view.backgroundColor = .systemFill
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Messages",
            style: .plain,
            target: self,
            action: #selector(messagesButtonTapped)
        )
    }

    @objc private func messagesButtonTapped() {
        let button = UIButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
//        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: <#T##UIFont#>)


    }
}
