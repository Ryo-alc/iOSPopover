//
//  HostingViewForPopover.swift
//  iOSPopover
//
//  Created by 岩永 涼 on 2023/07/25.
//

import Foundation
import SwiftUI

class HostingViewForPopover<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = view.intrinsicContentSize
    }
}
