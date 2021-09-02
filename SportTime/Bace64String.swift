//
//  Bace64String.swift
//  SportTime
//
//  Created by Alex on 27.05.2021.
//

import UIKit


class Bace64String {
    
   // static let shared = Bace64String()
    
    
    func encodeToString(image: UIImage) -> String {
            let imageData = image.pngData()!
            return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        }
        
        func decodingToImage(imageString: String) -> UIImage {
            var img = UIImage()
            let imageData = Data(base64Encoded: imageString,
                                 options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
            if imageData.isEmpty == true {
                img = UIImage(named: "unnamed")!
            } else {
                img = UIImage(data: imageData)!
            }
            return img
        }
    
}


