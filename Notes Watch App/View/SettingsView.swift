//
//  Settings.swift
//  Notes Watch App
//
//  Created by Paulina Wyskiel on 21/03/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("lineCount") var lineCount: Int = 1
    @AppStorage("ThemeColor") var themeColor: String = "AccentColor"
    
    @State private var value: Float = 1.0
    @State private var isInfoPresented: Bool = false
    
    func updateLineCount() {
        lineCount = Int(value)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8){
                
                HeaderView(title: "Settings")
                
                Text("Lines: \(lineCount)".uppercased())
                    .fontWeight(.bold)
                
                Slider(value: Binding(get: {
                    self.value
                }, set: {(newValue) in
                    self.value = newValue
                    self.updateLineCount()
                }), in: 1...4, step: 1)
                    .accentColor(Color(themeColor))
                
                Text("Theme ".uppercased())
                    .fontWeight(.bold)
                
                
                VStack {
                    HStack {
                        ThemeButtonView(color: "ColorYellow")
                        ThemeButtonView(color: "ColorBlue")
                        ThemeButtonView(color: "ColorGreen")
                        ThemeButtonView(color: "ColorRed")
                    }
                    HStack {
                        ThemeButtonView(color: "ColorPink")
                        ThemeButtonView(color: "AccentColor")
                    }
                }
                
                Spacer()
                Capsule()
                    .frame(height: 1)
                    .foregroundColor(.secondary)
                
                HStack {
                    Spacer()
                    Text("Get more info")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            isInfoPresented.toggle()
                        }
                        .sheet(isPresented: $isInfoPresented, content: {
                            InfoView()
                    })
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
