//
//  ContentView.swift
//  HundredDaysOfSwiftUI
//
//  Created by Max Gladkov on 28.12.2021.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}


struct ContentView: View {
    @State private var isTextRed = false
    
    var body: some View {
        Button("Turn button") {
            isTextRed.toggle()
        }
        .foregroundColor(isTextRed ? .red : .blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
