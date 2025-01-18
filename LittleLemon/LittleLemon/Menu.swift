//
//  Menu.swift
//  LittleLemon
//
//  Created by Havells on 18/01/25.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let persistenceController = PersistenceController.shared
    @State var searchText = ""
    
    
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
            
            NavigationView {
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()
                ) { (dishes: [Dish]) in
                    
                    List {
                        ForEach(dishes) { dish in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(dish.title ?? "")
                                    if let price = dish.price {
                                        Text("Price: $\(price)")
                                    } else {
                                        Text("Price: Not available")
                                    }

                                }
                                Spacer()
                                AsyncImage(url: URL(string: dish.image!)) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                }

                            }
                        }
                    }
                    // add the search bar modifier here
                    .searchable(text: $searchText, prompt: "Search....")
                }

            }

        }
        .onAppear {
            getMenuData()
        }
    }
    

    // Method to fetch menu data from the server
    func getMenuData() {
        // clear the the cache
        persistenceController.clear()
        print("Clearning the data")
        
        // 1. Define the server URL string
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"  // Replace with actual server URL
        
        // 2. Initialize the URL object (force unwrapping is safe because we know the URL is correct)
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // 3. Create the URLRequest instance
        let request = URLRequest(url: url)
        
        // 4. Create the data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response here
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Assuming the response is a JSON array of menu items (adjust accordingly)
            do {
                let fullMenu = try JSONDecoder().decode(JSONMenu.self, from: data)
                let menuItems = fullMenu.menu
                print(menuItems.count)
                for menuItem in menuItems {
                    
                    let dish = Dish(context: viewContext)
                    dish.title = menuItem.title
                    dish.price = menuItem.price
                    dish.image = menuItem.image
                }
                
                do {
                    if viewContext.hasChanges {
                        try viewContext.save()
                        print("dishes saved successfully")
                    }
                } catch {
                    print("Failed to save dishes: \(error)")
                }
                
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        
        // 5. Start the task
        task.resume()
    }
    
    
    func buildPredicate() -> NSPredicate {
        if(searchText.isEmpty) {
            return NSPredicate(value: true)
        }
        
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            
    }
    
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString .localizedCaseInsensitiveCompare)
            )
        ]
    }
    

}

#Preview {
    Menu()
}
