//
//  AlertCases.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 15/11/22.
//

import Foundation

enum AlertCases: String {
    case defaultError
    case emptyFields
    case usernameAlreadyExist
    case invalidEmail
    case emailAlreadyExist
    case success
    case weakPassword
    
    var alertTitle: String {
        switch self {
        case .defaultError:
            return "Error"
        case .emptyFields:
            return "Empty field"
        case .usernameAlreadyExist:
            return "Username already exist"
        case .invalidEmail:
            return "Invalid email"
        case .emailAlreadyExist:
            return "Email already exist"
        case .success:
            return "Success"
        case .weakPassword:
            return "Weak password"
        }
    }
    
    var alertDescription: String {
        switch self {
        case .defaultError:
            return "An error occurred, please try again later"
        case .emptyFields:
            return "You need to fill all fields to create an account"
        case .usernameAlreadyExist:
            return "You need to chosso another username"
        case .invalidEmail:
            return "Make sure you typed your email correctly"
        case .emailAlreadyExist:
            return "You need to use another email"
        case .success:
            return "success"
        case .weakPassword:
            return "You need to choose stronger password"
        }
    }
}
