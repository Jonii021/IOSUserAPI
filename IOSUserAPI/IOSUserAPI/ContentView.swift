//
//  ContentView.swift
//  IOSUserAPI
//
//  Created by Joni Jyrinki on 10.5.2023.
//

import SwiftUI

struct ContentView: View {
    @State var users: Array<User>? = nil
    @State var selectedTab = 0
    @State var search = ""
    var body: some View {
        
        VStack() {
            
            
            
            Spacer()
            
            TabView(selection:$selectedTab) {
                VStack() {
                    Text("User list")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    if (users != nil) {
                        
                        NavigationStack() {
                            List {
                                TextField("Search", text: $search){
                                    if ($search.wrappedValue.isEmpty){
                                        getUsers()
                                    }
                                    else {
                                        getUsers(url: "https://dummyjson.com/users/search?q=\($search.wrappedValue)")
                                    }
                                }
                                
                                    .padding(.leading, 20)
                                ForEach (users!, id: \.id) { user in
                                    VStack {
                                        HStack() {
                                            if (user.image != nil) {
                                                AsyncImage(
                                                    url: URL( string: user.image!),
                                                    content: { image in
                                                        image.resizable()
                                                             .aspectRatio(contentMode: .fit)
                                                             .frame(maxWidth: 50, maxHeight: 50)
                                                    },
                                                    placeholder: {
                                                        ProgressView()
                                                    })
                                            } else {
                                                Image(systemName: "person")
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(maxWidth: 50, maxHeight: 50)

                                            }

                                            
                                            
                                            VStack(alignment: .leading) {
                                                Text("\(user.firstName!) \(user.lastName!)")
                                                    .padding(.bottom, 4)
                                                Text("\(user.phone!)")
                                                    
                                            }
                                            .padding(.leading, 10.0)
                                            
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear(){
                    getUsers()
                }
                .tabItem({
                    Text("Person list")
                    Image(systemName: "person")
                })
                .tag(0)
                VStack {
                    AddUser()  
                }
                .tabItem({
                    Text("Add person")
                    Image(systemName: "person.fill.badge.plus")
                })
                .tag(1)
            }
            
        }
    }
    // function to connect and parse json
    func getUsers(url: String = "https://dummyjson.com/users") {
        print(url)
        let myURL = URL(string: url)!
        let httpTask = URLSession.shared.dataTask(with: myURL) {
            (optionalData, response, error) in
            let data = String(data: optionalData!, encoding: .utf8)!
            //            print(data)
            
            let jsonDecoder = JSONDecoder()
            let json = data.data(using: .utf8)!
            
            do {
                let result = try jsonDecoder.decode(ArrayUsers.self, from: json)
                //                print(result)
                users = result.users
                
            } catch {
                print(error)
            }
        }
        
        httpTask.resume()
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
