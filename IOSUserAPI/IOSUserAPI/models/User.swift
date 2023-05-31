//
//  User.swift
//  IOSUserAPI
//
//  Created by Joni Jyrinki on 10.5.2023.
//

import Foundation
/**
 User model for json result
 */
struct User: Decodable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let phone: String?
    let image: String?
}
