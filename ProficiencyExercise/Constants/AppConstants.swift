//
//  AppConstants.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    
    struct API {
        
        static let apiUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts"
    }
    
    
    struct FontStyle {
        
        enum Font: String {
            case avenir_regular = "Avenir-Book"
            case avenir_medium = "Avenir-Medium"
            
            enum Size: CGFloat {
                case xxlarge = 25
                case xlarge = 22
                case large = 20
                case medium = 18
                case small = 16
            }
            
            func font(size: Size) -> UIFont? {
                let fontSize = size.rawValue
                let fontName = self.rawValue
                return UIFont(name: fontName, size: fontSize)
            }
        }
    }
}

