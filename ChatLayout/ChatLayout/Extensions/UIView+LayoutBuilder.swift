//
//  UIView+LayoutBuilder.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 02.10.2021.
//

import UIKit

extension UIView {

    func constraint(_ configure: (_ builder: LayoutBuilder) -> Void) {
        configure(LayoutBuilder(with: self))
    }
}

final class LayoutBuilder {

    private unowned let targetView: UIView

    private var superview: UIView? {
        guard let superview = targetView.superview else {
            assertionFailure("Superview must exist")
            return nil
        }
        return superview
    }

    fileprivate init(with targetView: UIView) {
        self.targetView = targetView
        targetView.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Superview binding

    func equalToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            targetView.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            targetView.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left),
            targetView.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: insets.right),
            targetView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom)
        ])
    }

    func equalToSuperview(top: CGFloat = .zero, left: CGFloat = .zero, right: CGFloat = .zero, bottom: CGFloat = .zero) {
        equalToSuperview(insets: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }

    // MARK: - Top Binding

    func top(equalTo side: VerticalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = yAxisAnchor(from: view, with: side)
        targetView.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func top(greaterThanOrEqualTo side: VerticalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = yAxisAnchor(from: view, with: side)
        targetView.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    func top(lessThanOrEqualTo side: VerticalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = yAxisAnchor(from: view, with: side)
        targetView.topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    // MARK: - Bottom Binding

    func bottom(equalTo side: VerticalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = yAxisAnchor(from: view, with: side)
        targetView.bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func bottom(greaterThanOrEqualTo side: VerticalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = yAxisAnchor(from: view, with: side)
        targetView.bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    func bottom(lessThanOrEqualTo side: VerticalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = yAxisAnchor(from: view, with: side)
        targetView.bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    // MARK: - Left Binding

    func left(equalTo side: HorizontalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = xAxisAnchor(from: view, with: side)
        targetView.leftAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func left(greaterThanOrEqualTo side: HorizontalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = xAxisAnchor(from: view, with: side)
        targetView.leftAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    func left(lessThanOrEqualTo side: HorizontalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = xAxisAnchor(from: view, with: side)
        targetView.leftAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    // MARK: - Right Binding

    func right(equalTo side: HorizontalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = xAxisAnchor(from: view, with: side)
        targetView.rightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func right(greaterThanOrEqualTo side: HorizontalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = xAxisAnchor(from: view, with: side)
        targetView.rightAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    func right(lessThanOrEqualTo side: HorizontalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = xAxisAnchor(from: view, with: side)
        targetView.rightAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    // MARK: - Helpers

    private func yAxisAnchor(from view: UIView, with side: VerticalSide) -> NSLayoutYAxisAnchor {
        switch side {
        case .top:
            return view.topAnchor
        case .bottom:
            return view.bottomAnchor
        case .centerY:
            return view.centerYAnchor
        }
    }

    private func xAxisAnchor(from view: UIView, with side: HorizontalSide) -> NSLayoutXAxisAnchor {
        switch side {
        case .left:
            return view.leftAnchor
        case .right:
            return view.rightAnchor
        case .centerX:
            return view.centerXAnchor
        }
    }

    // MARK: - Center Binding

    func centerX(equalTo side: HorizontalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = xAxisAnchor(from: view, with: side)
        targetView.centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func centerX(equalToSuperviewWith constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        targetView.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant).isActive = true
    }

    func centerY(equalTo side: VerticalSide, of view: UIView, with constant: CGFloat = .zero) {
        let anchor = yAxisAnchor(from: view, with: side)
        targetView.centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func centerY(equalToSuperviewWith constant: CGFloat = .zero) {
        guard let superview = superview else { return }
        targetView.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant).isActive = true
    }

    // MARK: - Sides

    enum HorizontalSide {
        case left
        case right
        case centerX
    }

    enum VerticalSide {
        case top
        case bottom
        case centerY
    }
}
