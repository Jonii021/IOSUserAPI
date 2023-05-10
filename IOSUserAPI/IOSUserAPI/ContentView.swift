//
//  ContentView.swift
//  IOSUserAPI
//
//  Created by Joni Jyrinki on 10.5.2023.
//

import SwiftUI

struct ContentView: View {
    @State var users : Array<User>? = nil
    var body: some View {
        
        VStack() {
            Text("Star Wars API")
                .font(.title)
                .fontWeight(.bold)
            
            if (users != nil) {
                NavigationStack() {
                    List {
                        ForEach (users!, id: \.id) { user in
                            VStack {
                                HStack {
                                    //                                    AsyncImage(url: URL(string: user.image!))
                                    
                                    
                                    VStack {
                                        Text("\(user.firstName!) \(user.lastName!)")
                                        Text("\(user.phone!)")
                                    }
                                    .padding(.leading, 60.0)
                                    
                                    
                                    
                                }
                                
                            }
                        }
                    }
                }
            }
            
            
            Spacer()
            
            Button("Fetch") {
                getUsers()
            }
            
        }
    }
    // function to connect and parse json
    func getUsers() {
        let myURL = URL(string: "https://dummyjson.com/users")!
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
