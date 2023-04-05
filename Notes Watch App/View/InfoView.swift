//
//  InfoView.swift
//  Notes Watch App
//
//  Created by Paulina Wyskiel on 21/03/2023.
//

import SwiftUI

struct InfoView: View {
    //MARK: - BODY
    
    var body: some View {
        VStack(spacing: 2) {
            
            HeaderView(title: "Info")
        
            DataView(type: "Version", info: "1.0")
            DataView(type: "Compability", info: "9.3.1")
            DataView(type: "SwiftUI", info: "4.0")
            DataView(type: "Developer", info: "Paulina Wyskiel")
            
           
        }
    }
}

//MARK: - PREVIEW

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
