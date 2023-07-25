//
//  PopoverController.swift
//  iOSPopover
//
//  Created by 岩永 涼 on 2023/07/25.
//

import Foundation
import SwiftUI

struct PopoverController<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var content: Content

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            let popoverController = HostingViewForPopover(rootView: content)
            popoverController.view.backgroundColor = .clear
            popoverController.modalPresentationStyle = .popover
            popoverController.popoverPresentationController?.permittedArrowDirections = .up
            popoverController.popoverPresentationController?.popoverBackgroundViewClass = PopoverBackgroundView.self
            popoverController.presentationController?.delegate = context.coordinator
            popoverController.popoverPresentationController?.sourceView = uiViewController.view
            uiViewController.present(popoverController, animated: true)
        }
    }

    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        var parent: PopoverController

        init(parent: PopoverController) {
            self.parent = parent
        }

        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }

        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
        }
    }
}
