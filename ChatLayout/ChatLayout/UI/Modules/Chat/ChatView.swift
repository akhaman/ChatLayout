//
//  ChatView.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 07.10.2021.
//

import UIKit

typealias ChatMessage = String

struct DailyChatHistory: Hashable {

}

class ChatView: UIView {

    private typealias Item = ChatMessage
    private typealias Section = DailyChatHistory
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, ChatMessage>

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCompositionalLayout())
    private lazy var dataSource = makeDataSource()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        collectionView.backgroundColor = .adaptedFor(light: .primaryWhite, dark: .primaryBlack)
        collectionView.dataSource = dataSource

        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

// MARK: - Diffable Data Source

extension ChatView {

    private func makeDataSource() -> DataSource {
        // TODO: - Not Implemented
        fatalError("Not implemented")
    }
}

// MARK: - Compostional Layout

extension ChatView {

    private func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        // TODO: - Not Implemented
        fatalError("Not implemented")
    }
}
