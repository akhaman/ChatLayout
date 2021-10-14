//
//  Notification+KeyboardInfo.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 14.10.2021.
//

import UIKit

extension Notification {

    var keyboardInfo: KeyboardInfo? {
        guard let userInfo = userInfo,
              let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
              let curve = UIView.AnimationCurve(rawValue: curveValue) else { return nil }

        let endFrame = keyboardValue.cgRectValue

        let keyboardHeight = endFrame.height
        let isKeyboardPresented = endFrame.minY < UIScreen.main.bounds.maxY

        return KeyboardInfo(duration: duration, curve: curve, keyboardHeight: keyboardHeight, isPresented: isKeyboardPresented)
    }

    struct KeyboardInfo {
        let duration: TimeInterval
        let curve: UIView.AnimationCurve
        let keyboardHeight: CGFloat
        let isPresented: Bool
    }
}
