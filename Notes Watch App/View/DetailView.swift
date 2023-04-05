//
//  DetailView.swift
//  Notes Watch App
//
//  Created by Paulina Wyskiel on 21/03/2023.
//

import SwiftUI

struct DetailView: View {
    //MARK: - PROPERTY
    
    let note: Note
    let count: Int
    let index: Int
    
    //MARK: - BODY
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            HeaderView(title: "")
            
            Spacer()
            
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            
            HStack(alignment: .center) {
                Spacer()
                Text("\(index + 1) / \(count) ")
                Spacer()
            }
            .foregroundColor(.secondary)
        }
        .padding(3)
    }
}

//MARK: - PREVIEW

struct DetailView_Previews: PreviewProvider {
    static var sampleData: Note = Note(id: UUID(), text: "Init note")
    
    static var previews: some View {
        DetailView(note: sampleData, count: 10, index: 1)
    }
}
