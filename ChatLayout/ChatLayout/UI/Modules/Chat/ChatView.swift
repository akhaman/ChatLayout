//
//  ChatView.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 07.10.2021.
//

import UIKit

class ChatView: UIView {

    private typealias Item = ChatMessageModel
    private typealias Section = ChatSectionModel
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, ChatMessageModel>

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
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
        collectionView.delegate = self

        collectionView.register(ChatTextMessageCell.self)

        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Updating

    func update(withSections sections: [ChatSectionModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach { snapshot.appendItems($0.messages, toSection: $0)}

        dataSource.apply(snapshot)
    }
}

// MARK: - UICollectionViewDelegate

extension ChatView: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let message = dataSource.itemIdentifier(for: indexPath) else { return .zero }
        
        return TextMessageLayoutCalculator.size(forCellWithMessage: message)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        ChatAppearance.minimumLineSpacing
    }
}

// MARK: - Diffable Data Source

extension ChatView {

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, message in
            collectionView.dequeue(ChatTextMessageCell.self, for: indexPath).updated(withMessage: message)
        }

        return dataSource
    }
}

// MARK: - Compostional Layout

extension ChatView {

    private func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = ChatAppearance.sectionInsets
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }
}
