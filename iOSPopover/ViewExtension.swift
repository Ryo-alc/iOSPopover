//
//  ViewExtension.swift
//  iOSPopover
//
//  Created by 岩永 涼 on 2023/07/25.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func iOSPopover<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.background {
            PopoverController(isPresented: isPresented, content: content())
        }
    }
}
