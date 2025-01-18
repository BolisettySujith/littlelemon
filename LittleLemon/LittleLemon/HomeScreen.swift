//
//  HomeScreen.swift
//  LittleLemon
//
//  Created by Havells on 18/01/25.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack{
            TabView {
                Text("This is the Share View")
                    .tabItem{
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                
                // Add the Menu screen as a new tab
                Menu()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                
                UserProfile()
                    .tabItem {
                        Label("Profile", systemImage: "square.and.pencil")
                    }

            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    HomeScreen()
}
