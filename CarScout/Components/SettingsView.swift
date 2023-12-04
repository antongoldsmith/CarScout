//
//  SettingsView.swift
//  CarScout
//
//  Created by Anton Goldsmith on 12/3/23.
//

import SwiftUI

struct SettingsView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        SettingsView(imageName: "gear", title: "Version", tintColor: Color.gray)
    }
}
