//
//  DataView.swift
//  Notes Watch App
//
//  Created by Paulina Wyskiel on 22/03/2023.
//

import SwiftUI

struct DataView: View {
    
    let type: String
    let info: String
    
    var body: some View {
        HStack {
            Text(type)
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
                .fixedSize()
        
            Spacer()
        
            Text(info)
                .font(.footnote)
                .foregroundColor(.primary)
                .fontWeight(.semibold)
                .fixedSize()
            
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(type: "", info: "")
    }
}
