//
//  HeaderView.swift
//  Notes Watch App
//
//  Created by Paulina Wyskiel on 21/03/2023.
//

import SwiftUI

struct HeaderView: View {
    //MARK: - PROPERTY
    
    @AppStorage("ThemeColor") var themeColor: String = "AccentColor"
    
    var title: String = ""
    
    //MARK: - BODY
    
    var body: some View {
        VStack {
            if title != "" {
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(themeColor))
            }
            HStack{
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            }
            .foregroundColor(Color(themeColor))
        }
    }
}

//MARK: - PREVIEW

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(title: "Credits")
            
            HeaderView()
        }
    }
}
