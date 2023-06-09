//
//  ThemeButtonView.swift
//  Notes Watch App
//
//  Created by Paulina Wyskiel on 22/03/2023.
//

import SwiftUI

struct ThemeButtonView: View {
    //MARK: - PROPERTY
    
    @AppStorage("ThemeColor") var themeColor: String = "AccentColor"
    
    let color: String
    
    //MARK: - BODY
    var body: some View {
        Button {
            themeColor = color
        } label: {
            Image(systemName: "circle.fill")
                .font(.system(size: 32))
                .fixedSize()
                .foregroundColor(Color(color))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

//MARK: - PREVIEW

struct ThemeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeButtonView(color: "AccentColor")
    }
}
