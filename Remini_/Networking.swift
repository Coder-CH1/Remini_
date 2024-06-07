//
//  ImageData.swift
//  Remini_
//
//  Created by Mac on 07/06/2024.
//

import Foundation

class NetworkingManager {
    static let shared = NetworkingManager()
    
    func fetchImageUrls(completion: @escaping([ImageData]) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "http://localhost:3001/images")!) { data, response, error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else  if let data = data {
                do {
                    let decode = try JSONDecoder().decode([ImageData].self, from: data)
                        completion(decode)
                    print("\(decode.count)")
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
