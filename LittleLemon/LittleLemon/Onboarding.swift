//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Havells on 18/01/25.
//

let kFirstName = "firstNameKey"
let kLastName = "lastNameKey"
let kEmailAddress = "emailAddressKey"
let kIsLoggedIn = "kIsLoggedIn"


import SwiftUI

struct Onboarding: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email : String = ""
    
    @State var isLoggedIn : Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                
                NavigationLink(destination: HomeScreen(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                TextField(
                    "Enter your first name",
                    text: $firstName
                )
                .onChange(of: firstName, perform:{ newvalue in
                    print(newvalue)
                })
                TextField(
                    "Enter your last name",
                    text: $lastName
                )
                .onChange(of: lastName, perform:{ newvalue in
                    print(newvalue)
                })
                TextField(
                    "Enter your email address",
                    text: $email
                )
                .onChange(of: email, perform:{ newvalue in
                    print(newvalue)
                })
                
                Button("Register"){
                    if firstName.isEmpty && lastName.isEmpty && email.isEmpty {
                        
                    } else {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmailAddress)
                        UserDefaults.standard.setValue(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                        
                    }
                }
            }
            .onAppear {
                let isLog = UserDefaults.standard.bool(forKey: kIsLoggedIn)
                if  isLog {
                    isLoggedIn = true
                }
            }
            .padding()
        }
    }
}

#Preview {
    Onboarding()
}
