//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Havells on 18/01/25.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName)
    let lastName = UserDefaults.standard.string(forKey: kLastName)
    let emailAddress = UserDefaults.standard.string(forKey: kEmailAddress)
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Text(firstName ?? "")
            Text(lastName ?? "")
            Text(emailAddress ?? "")
            
            Spacer()
            
            Button("Logout") {
                UserDefaults.standard.setValue(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    UserProfile()
}
