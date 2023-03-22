//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Paulina Wyskiel on 20/03/2023.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTY
    
    @AppStorage("lineCount") var lineCount: Int = 1
    @AppStorage("ThemeColor") var themeColor: String = "AccentColor"
    
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    @State private var isSettingsPresented: Bool = false
    
    //MARK: - FUNCTION
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save(){
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Saving data has failed.")
        }
    }
    
    
    func load() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                //Do nothing
            }
        }
    }

    func delete(offsets: IndexSet){
        withAnimation{
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center, spacing: 4){
                    TextField("Add New Note", text: $text)
                    
                    Button {
                        guard text.isEmpty == false else { return }
                        
                        let note = Note(id: UUID(), text: text)
                        
                        notes.append(note)
                        text = ""
                        save()
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 25, weight: .semibold))
                            .fixedSize()
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(Color(themeColor))
                }
                Spacer()
               
                    if notes.count >= 1 {
                        List {
                            ForEach(0..<notes.count, id: \.self) { i in
                                
                                NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)){
                                    HStack {
                                        Capsule()
                                            .frame(width: 4)
                                            .foregroundColor(Color(themeColor))
                                        Text(notes[i].text)
                                            .lineLimit(lineCount)
                                            .padding(.horizontal, 5)
                                    }
                                
                            }
                        }
                        .onDelete(perform: delete)
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(25)
                    Spacer()
                
                }
                HStack {
                    Spacer()
                    
                    Image(systemName: "gear")
                        .imageScale(.medium)
                        .onTapGesture {
                            isSettingsPresented.toggle()
                        }
                        .sheet(isPresented: $isSettingsPresented, content: {
                            SettingsView()
                    })
                    
                }
                .foregroundColor(.secondary)

            }
            .onAppear(perform: {
                load()
        })
        }
    }
}


//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
