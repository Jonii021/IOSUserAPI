//
//  AddUser.swift
//  IOSUserAPI
//
//  Created by Joni Jyrinki on 19.5.2023.
//

import SwiftUI

struct AddUser: View {
    @State var addUser = (firstName : "", lastName : "", phone : "")
    @State var isPresented = false
    var body: some View {
        
        VStack(){
            Text("Add user")
                .font(.title)
                .fontWeight(.bold)
            
            Form{
                TextField("Firstname", text: $addUser.firstName)
                TextField("Lastname", text: $addUser.lastName)
                TextField("Phone number", text: $addUser.phone)
                Button("Submit"){
                    postUser(params: addUser)
                    isPresented = true
                    
                }
                .alert("User added!", isPresented: $isPresented, actions: {})
            }
            
        }

    }
    
    
    
    
    func postUser(params: (firstName: String, lastName: String, phone: String)) {
        let myURL = URL(string: "https://dummyjson.com/users/add")!
        var request = URLRequest(url: myURL)
        request.httpMethod = "POST"

        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "firstName=\(params.firstName)&lastName=\(params.lastName)&phone=\(params.phone)";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                }
        }
        task.resume()
    }
    
}

struct AddUser_Previews: PreviewProvider {
    static var previews: some View {
        AddUser()
    }
}
