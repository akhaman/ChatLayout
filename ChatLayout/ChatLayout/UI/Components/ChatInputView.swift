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
        field.font = .font(ofSize: 14, forTextStyle: .body)
        field.backgroundColor = .adaptedFor(light: .messageLighterGray, dark: .darkGray)
        field.layer.masksToBounds = true
        field.attributedPlaceholder = NSAttributedString(string: "Type your message here...", attributes: [
            .font: UIFont.font(ofSize: 14, forTextStyle: .body),
            .foregroundColor: UIColor.adaptedFor(light: .primaryBlack, dark: .socialWhite)
        ])
        field.addTarget(self, action: #selector(textFieldDidChangeEditing), for: .editingChanged)

        return field
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setBackgroundImage(.chatButton, for: .normal)
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)

        return button
    }()

    // MARK: - Callbacks

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
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 16, bottom: 36, right: 16))
        }

        textField.addSubview(sendButton)
        sendButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(4)
            $0.size.equalTo(32)
        }
    }

    private func addSeparator() {
        let separatorView = UIView()
        separatorView.backgroundColor = .adaptedFor(light: .messageLighterGray, dark: .darkGray)

        addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    @objc private func buttonDidTap() {
        guard let text = textField.text, !text.isEmpty else { return }
        onButtonDidTap?(text)
        textField.text = ""
        sendButton.isEnabled = false
    }

    @objc private func textFieldDidChangeEditing() {
        sendButton.isEnabled = textField.hasText
    }
}
