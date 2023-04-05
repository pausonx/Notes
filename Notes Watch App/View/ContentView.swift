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
    
    /**
     Function that returns the path to the Documents directory in the application sandbox.
     
     - Returns: The path to the Documents directory in the application sandbox.
     
     - Note: The Documents directory is used to store files that are created and managed by the user. All files stored in this directory are automatically synchronized with iCloud if the user enables this feature.
     
     - Important: The function assumes that the application has permissions to access the Documents directory. If the application does not have these permissions, the function will return an error.
     
     - Warning: the Documents directory is one of the few directories that the app can access directly. Therefore, you should be careful about what you store in it and always make sure that the contents of this directory are safe for the user and do not violate the user's privacy.
     
     - Complexity: The runtime of the function is constant at O(1).
     */
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    /**
     Saves the current notes to disk in JSON format.
     
     - Throws: An error if the data cannot be saved to disk.
     
     - Note: This function encodes the `notes` array as JSON data and saves it to a file called "notes" in the app's Documents directory. If the file already exists, its contents will be overwritten.
     
     - Important: This function assumes that the app has permission to access the Documents directory. If the app doesn't have this permission, the function will fail.
     
     - Complexity: The time complexity of this function is O(n), where n is the number of notes in the `notes` array.
     */
    func save(){
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Saving data has failed.")
        }
    }
    
    /**
     Loads saved notes from disk into the `notes` array.
     
     - Note: This function attempts to read a file called "notes" in the app's Documents directory and decodes its contents as an array of `Note` objects using JSON decoding. If the file cannot be found or the data is invalid, the function does nothing.
     
     - Complexity: The time complexity of this function is O(n), where n is the number of notes in the file.
     */
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

    /**
     Deletes the notes at the specified offsets from the `notes` array and saves the updated array to disk.
     
     - Parameter offsets: The indexes of the notes to delete from the `notes` array.
     
     - Important: This function mutates the `notes` array directly and saves the updated array to disk. If the save operation fails, the `notes` array will be out of sync with the saved data.
     */
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
