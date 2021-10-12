//
//  ChatInputView.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 10.10.2021.
//

import UIKit

class ChatInputView: UIView {

    // MARK: - Subviews

    private lazy var textField: UITextField = {
        let field = TextFieldWithInsets()
        field.layer.masksToBounds = true
        field.attributedPlaceholder = NSAttributedString(string: "Type your message here...", attributes: [
            .font: UIFont.font(ofSize: 14, forTextStyle: .body),
            .foregroundColor: UIColor.adaptedFor(light: .primaryBlack, dark: .socialWhite)
        ])
        field.font = .font(ofSize: 14, forTextStyle: .body)
        field.backgroundColor = .adaptedFor(light: .messageLighterGray, dark: .darkGray)
        return field
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.chatButton, for: .normal)
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return button
    }()

    // MARK: - Calbacks

    var onButtonDidTap: ((_ text: String) -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textField.layer.cornerRadius = textField.frame.height / 2
    }

    // MARK: - Setup

    private func setup() {
        addSeparator()
        backgroundColor = .adaptedFor(light: .primaryWhite, dark: .pureBlack)

        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textField.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -36),

            sendButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: 4),
            sendButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -4),
            sendButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -4),
            sendButton.heightAnchor.constraint(equalToConstant: 32),
            sendButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }

    private func addSeparator() {
        let separatorView = UIView()
        separatorView.backgroundColor = .adaptedFor(light: .messageLighterGray, dark: .darkGray)

        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    @objc private func buttonDidTap() {
        guard let text = textField.text, !text.isEmpty else { return }
        onButtonDidTap?(text)
        textField.text = ""
    }
}
