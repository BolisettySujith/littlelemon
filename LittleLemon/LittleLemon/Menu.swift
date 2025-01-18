//
//  Menu.swift
//  LittleLemon
//
//  Created by Havells on 18/01/25.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            // Title of the application
            Text("My Restaurant App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            // Restaurant location
            Text("Chicago")
                .font(.title2)
                .padding(.bottom, 5)
            
            // Short description
            Text("Explore our delicious menu and enjoy the best dining experience!")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Placeholder for the menu list
            List {
                // Menu items will be added here later
            }
            .padding(.top, 20)

        }
    }
}

#Preview {
    Menu()
}
