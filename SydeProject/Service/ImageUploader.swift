//
//  ImageUploader.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-02-25.
//

import Firebase
import UIKit

struct ImageUploader {
    
    static func uploadImage (image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality:  0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG FAiled to upload image with error: \(error.localizedDescription)")
                return
            }
            ref.downloadURL { imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
