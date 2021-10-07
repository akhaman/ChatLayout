//
//  MessagesView.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 04.10.2021.
//

import UIKit

class MessagesView: UIView {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, ChatPreview>

    private enum Constants {
        static let pinnedSectonTitle = "PINNED"
    }

    private enum Section: Int, CaseIterable {
        case pinned
        case chats
    }

    // MARK: - Output

    var onSelectChat: ((_ chat: ChatPreview) -> Void)?

    // MARK: - Properties

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCompositionalLayoyt())
    private lazy var dataSource = makeDataSource()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Updating

    func update(pinnedChats pinned: [ChatPreview], listedChats listed: [ChatPreview]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatPreview>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(pinned, toSection: .pinned)
        snapshot.appendItems(listed, toSection: .chats)
        dataSource.apply(snapshot)
    }

    // MARK: - Setup

    private func setupCollectionView() {
        collectionView.backgroundColor = .adaptedFor(light: .primaryWhite, dark: .primaryBlack)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.register(MessagesVerticalCell.self, MessagesHorizontalCell.self)
        collectionView.register(CollectionHeaderFooterView.self, withKind: UICollectionView.elementKindSectionHeader)

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

// MARK: - CollectionViewDelegate

extension MessagesView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let chat = dataSource.itemIdentifier(for: indexPath) else { return }
        onSelectChat?(chat)
    }
}

// MARK: - CollectionViewDataSource

extension MessagesView {

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, chat in
            let sectionType = Section(rawValue: indexPath.section)

            switch sectionType {
            case .pinned:
                return collectionView.dequeue(MessagesVerticalCell.self, for: indexPath)
                    .updated(withImage: chat.image, name: chat.firstName)
            case .chats:
                return collectionView.dequeue(MessagesHorizontalCell.self, for: indexPath)
                    .updated(withFullName: chat.fullName, image: chat.image, message: chat.message, date: chat.date)
            case .none:
                return nil
            }
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader,
                  Section(rawValue: indexPath.section) == .pinned else { return nil }

            return collectionView.dequeue(CollectionHeaderFooterView.self, ofKind: kind, indexPath: indexPath)
                .updated(with: Constants.pinnedSectonTitle)
        }

        return dataSource
    }
}

// MARK: - Compositional Layout

extension MessagesView {

    private func makeCompositionalLayoyt() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [unowned self] sectionIndex, environment in
            let sectionType = Section(rawValue: sectionIndex)

            switch sectionType {
            case .pinned:
                return makePinnedLayoutSection()
            case .chats:
                return makeChatsLayoutSection()
            case .none:
                return nil
            }
        }
    }

    private func makePinnedLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(48), heightDimension: .estimated(70))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 32
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 24, bottom: 20, trailing: 24)

        return section
    }

    private func makeChatsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(92))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}
