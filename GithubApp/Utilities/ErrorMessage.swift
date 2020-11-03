//
//  ErrorMessage.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/2/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import Foundation
 
enum GFError: String, Error {
    case invalidUsername =  "This username created is an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse =  "Invalid response from the server. Please try again."
    case invalidData =       "The data recieved from the server was invalid.Please try again."
}
