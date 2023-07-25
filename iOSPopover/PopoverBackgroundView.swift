//
//  PopoverBackgroundView.swift
//  iOSPopover
//
//  Created by 岩永 涼 on 2023/07/25.
//

import Foundation
import SwiftUI

final class PopoverBackgroundView: UIPopoverBackgroundView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowOpacity = 0
        setupBackgroundShapeLayer()
    }

    override static func arrowBase() -> CGFloat {
        return 20
    }

    override static func arrowHeight() -> CGFloat {
        return 10
    }

    override static func contentViewInsets() -> UIEdgeInsets {
        return .zero
    }

    private var _arrowOffset: CGFloat = 0
    override var arrowOffset: CGFloat {
        get { return _arrowOffset }
        set { _arrowOffset = newValue }
    }

    override var arrowDirection: UIPopoverArrowDirection {
        get { return .up }
        set {}
    }

    private func setupBackgroundShapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = generatePath(bounds, cornerRadius: 10).cgPath
        shapeLayer.fillColor = #colorLiteral(red: 0.1176470588, green: 0.5294117647, blue: 0.9215686275, alpha: 1)
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        shapeLayer.lineWidth = 2
        layer.addSublayer(shapeLayer)
    }

    private func generatePath(_ rect: CGRect, cornerRadius: CGFloat) -> UIBezierPath {
        let insets: UIEdgeInsets = {
            var insets = PopoverBackgroundView.contentViewInsets()
            insets.top += PopoverBackgroundView.arrowHeight()
            return insets
        }()

        let topLeft = CGPoint(x: insets.left, y: insets.top)
        let topRight = CGPoint(x: rect.maxX - insets.right, y: insets.top)
        let bottomRight = CGPoint(x: rect.maxX - insets.right, y: rect.maxY - insets.bottom)
        let bottomLeft = CGPoint(x: insets.left, y: rect.maxY - insets.bottom)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y))

        let arrowBase = PopoverBackgroundView.arrowBase()
        let arrowCenterX = rect.size.width / 2 + _arrowOffset
        path.addLine(to: CGPoint(x: arrowCenterX - arrowBase / 2, y: insets.top))
        path.addLine(to: CGPoint(x: arrowCenterX, y: 0))
        path.addLine(to: CGPoint(x: arrowCenterX + arrowBase / 2, y: insets.top))

        path.addLine(to: CGPoint(x: topRight.x - cornerRadius, y: topRight.y))
        path.addQuadCurve(to: CGPoint(x: topRight.x, y: topRight.y + cornerRadius), controlPoint: topRight)
        path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - cornerRadius))
        path.addQuadCurve(to: CGPoint(x: bottomRight.x - cornerRadius, y: bottomRight.y), controlPoint: bottomRight)
        path.addLine(to: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y))
        path.addQuadCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y - cornerRadius), controlPoint: bottomLeft)
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + cornerRadius))
        path.addQuadCurve(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y), controlPoint: topLeft)

        return path
    }
}
