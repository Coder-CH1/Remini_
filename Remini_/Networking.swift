//
//  ImageData.swift
//  Remini_
//
//  Created by Mac on 07/06/2024.
//

import Foundation

class NetworkingManager {
    static let shared = NetworkingManager()
    
    func fetchImageUrls(completion: @escaping(ImageData) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "http://localhost:3002/images")!) { data, response, error in
            if let error = error {
                print(String(describing: error))
            } else  if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(ImageData.self, from: data)
                        completion(decodedData)
                    print("\(decodedData.imgUrls)")
                } catch {
                    print(String(describing: error))
                }
            }
        }.resume()
    }
}
