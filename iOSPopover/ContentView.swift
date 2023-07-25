//
//  ContentView.swift
//  iOSPopover
//
//  Created by 岩永 涼 on 2023/07/25.
//

import SwiftUI

struct ContentView: View {
    @State var isPresented: Bool = false

    var body: some View {
        Button("\(isPresented ? "Dismiss" : "Present")") {
            isPresented.toggle()
        }
        .iOSPopover(isPresented: $isPresented) {
            Text("Popover")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
