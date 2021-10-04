//
//  MessagesView.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 04.10.2021.
//

import UIKit

class MessagesView: UIView {

    // MARK: - Properties

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private lazy var dataSource = makeDataSource(with: collectionView)
    private lazy var layout = makeCompositionalLayoyt()

    var onSelectChat: ((_ chat: Chat) -> Void)?

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
        collectionView.register(MessagesHorizontalCell.self)
        addSubview(collectionView)
        collectionView.layout {
            $0.equalToSuperview()
        }
    }

    // MARK: - Updating

    func update(pinnedChats pinned: [Chat], listedChats listed: [Chat]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Chat>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(pinned, toSection: .pinned)
        snapshot.appendItems(listed, toSection: .chats)
        dataSource.apply(snapshot)
    }
}

// MARK: - Models

extension MessagesView {
    enum Section: Int, CaseIterable {
        case pinned
        case chats
    }

    struct Chat: Hashable {
        let id: String
        let name: String
        let image: UIImage
        let message: String
        let date: String
    }
}

// MARK: - CollectionViewDelegate

extension MessagesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let chat = dataSource.itemIdentifier(for: indexPath) else { return }
        onSelectChat?(chat)
    }
}

// MARK: - CollectionViewDataSource

extension MessagesView {
    private func makeDataSource(with collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, Chat> {
        UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, chat in
            collectionView.dequeue(MessagesHorizontalCell.self, for: indexPath).updated(with: chat)
        }
    }
}

// MARK: - Layout

extension MessagesView {
    private func makeCompositionalLayoyt() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let self = self else { return nil }
            switch Section(rawValue: sectionIndex) {
            case .pinned:
                return self.makePinnedLayoutSection()
            case .chats:
                return self.makeChatsLayoutSection()
            case .none:
                return nil
            }
        }
        return layout
    }

    private func makePinnedLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalWidth(0.5)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    private func makeChatsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(92)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}
