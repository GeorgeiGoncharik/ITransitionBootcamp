//
//  SettingsView.swift
//  Dailye
//
//  Created by Mac on 17.01.21.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showDetailCountry = false
    @State private var showDetailLanguage = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20) {
                    GroupBox(
                        label: SettingsLabel(text: "Dailye", imageSF: "info.circle")
                    ){
                        Divider().padding(.vertical, 4)
                        HStack(alignment: .center, spacing: 10){
                            Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(9.0)
                            Text("Fast and easy news reader for your country's most popular news and newspapers. Stay up to date with your country news and compare them with different sources.")
                                .font(.footnote)
                        }
                    }.cardLook()
                    
                    GroupBox(
                        label: SettingsLabel(text: "Localization", imageSF: "flag")
                    ){
                        VStack{
                            Group{
                                Divider().padding(.vertical, 4)
                                HStack{
                                    Text("Country").foregroundColor(.gray)
                                    Spacer()
                                    Text("\(viewModel.selectedCountry.rawValue)")
                                    Button(
                                        action: {
                                            showDetailCountry.toggle()
                                        }
                                    ){
                                        Image(systemName: "arrow.right.square").cardAccent()
                                            .rotationEffect(.degrees(showDetailCountry ? 90 : 0))
                                            .scaleEffect(showDetailCountry ? 1.2 : 1.0)
                                    }
                                }
                                if showDetailCountry{
                                    Picker(selection: $viewModel.selectedCountry, label: Text("Please choose a country")) {
                                        ForEach(viewModel.countries, id: \.self) { country in
                                            Text("\(country.rawValue)")
                                                .tag(country)
                                        }
                                    }
                                }
                            }
                            Group{
                                Divider().padding(.vertical, 4)
                                HStack{
                                    Text("Language").foregroundColor(.gray)
                                    Spacer()
                                    Text("\(viewModel.selectedLanguage.rawValue)")
                                    Button(
                                        action: {
                                            showDetailLanguage.toggle()
                                        }
                                    ){
                                        Image(systemName: "arrow.right.square").cardAccent()
                                            .rotationEffect(.degrees(showDetailLanguage ? 90 : 0))
                                            .scaleEffect(showDetailLanguage ? 1.2 : 1.0)
                                    }
                                }
                                if showDetailLanguage{
                                    Picker(selection: $viewModel.selectedLanguage, label: Text("Please choose a language")) {
                                        ForEach(viewModel.languages, id: \.self) { language in
                                            Text("\(language.rawValue)")
                                                .tag(language)
                                        }
                                    }
                                }
                            }
                        }
                    }.cardLook()
                    
                    GroupBox(
                        label: SettingsLabel(text: "Application", imageSF: "apps.iphone")
                    ){
                        SettingsRow(name: "Developer", content: "Georgei Goncharik")
                        SettingsRow(name: "E-mail", linkLabel: "contact a developer", email: "georgii.goncharik@gmail.com")
                        SettingsRow(name: "VK", linkLabel: "@g.goncharik", link: "https://vk.com/g.goncharik")
                        
                    }.cardLook()
                }
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SettingsLabel: View{
    var text: String
    var imageSF: String
    
    var body: some View{
        HStack{
            Text(text)
                .bold()
            Spacer()
            Image(systemName: imageSF)
        }
        .font(.title3)
        .lineLimit(1)
        .cardText()
    }
}

struct SettingsRow: View{
    var name: String
    var content: String?
    var linkLabel: String?
    var link: String?
    var email: String?
    
    var body: some View{
        VStack{
            Divider().padding(.vertical, 4)
            HStack{
                Text(name).foregroundColor(.gray)
                Spacer()
                if(content != nil){
                    Text(content!)
                } else if (linkLabel != nil){
                    if(link != nil){
                        Link(linkLabel!, destination: URL(string: "\(link!)")!)
                        Image(systemName: "arrow.up.right.square").cardAccent()
                    }
                    if(email != nil){
                        Button(linkLabel!){
                            if let url = URL(string: "mailto:\(email!)") {
                              if #available(iOS 10.0, *) {
                                UIApplication.shared.open(url)
                              } else {
                                UIApplication.shared.openURL(url)
                              }
                            }
                        }.buttonStyle(BorderlessButtonStyle())
                        Image(systemName: "arrow.up.right.square").cardAccent()
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
