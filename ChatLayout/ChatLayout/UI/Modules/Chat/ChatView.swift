//
//  ChatView.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 07.10.2021.
//

import UIKit

class ChatView: UIView {

    private typealias Item = ChatMessageItem
    private typealias Section = ChatSectionIdentifier
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, ChatMessageItem>

    // MARK: - Subviews

    private lazy var chatInputView = ChatInputView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
    private lazy var dataSource = makeDataSource()

    // MARK: - Callbacks

    var onSendMessageButtonDidTap: ((_ text: String) -> Void)? {
        get { chatInputView.onButtonDidTap }
        set { chatInputView.onButtonDidTap = newValue }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupCollectionView() {
        collectionView.backgroundColor = ChatAppearance.backgroundColor
        collectionView.dataSource = dataSource
        collectionView.delegate = self

        collectionView.register(ChatTextMessageCell.self)
        collectionView.register(ChatDateHeaderView.self, withKind: UICollectionView.elementKindSectionHeader)
    }

    private func setupLayout() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(chatInputView)
        chatInputView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),

            chatInputView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            chatInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chatInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chatInputView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Updating

    func reload(groups: [ChatMessagesGroup]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(groups.map { $0.sectionId })

        groups.forEach { group in
            snapshot.appendItems(group.messageItems, toSection: group.sectionId)
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func scrollToLastMessage() {
        let section = max(0, collectionView.numberOfSections - 1)
        let item = max(0, collectionView.numberOfItems(inSection: section) - 1)

        collectionView.scrollToItem(at: IndexPath(item: item, section: section), at: .bottom, animated: true)
    }
}

// MARK: - CollectionViewDelegate

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

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 24)
    }
}

// MARK: - DiffableDataSource

extension ChatView {

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, message in
            collectionView.dequeue(ChatTextMessageCell.self, for: indexPath).updated(withMessage: message)
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let snapshot = dataSource.snapshot()
            let section = snapshot.sectionIdentifiers[indexPath.section]

            return collectionView.dequeue(
                ChatDateHeaderView.self,
                ofKind: UICollectionView.elementKindSectionHeader,
                indexPath: indexPath
            )
            .updated(withTitle: section.dateText)
        }

        return dataSource
    }
}

// MARK: - CollectionViewLayout

extension ChatView {

    private func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = ChatAppearance.sectionInsets
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true

        return layout
    }
}
