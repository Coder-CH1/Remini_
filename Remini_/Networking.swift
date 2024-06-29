//
//  ImageData.swift
//  Remini_
//
//  Created by Mac on 07/06/2024.
//

import Foundation
import SQLite3
// SQLite

class ImageManager {
    static let shared = ImageManager()
    
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

class DatabaseManager {
    static let shared = DatabaseManager()
    let db: Connection?
    private init() {
        do {
            db = try
            Connection(.inMemory)
            createTable()
        } catch {
            db = nil
            print("Unable to connect to database: \(error)")
        }
    }
    func createTable() {
        let users = Table("users")
        let gender = Expression<String>("gender")
        do {
            try db!.run(users.create{ t in
                t.column(gender)
            })
        } catch {
            print("Unable to create table: \(error)")
        }
    }
    
    func saveGender(_ gender: String) {
        let users = Table("users")
        let genderColumn = Expression<String>("gender")
        do {
            try db?.run(users.insert(genderColumn <- gender))
        } catch {
            print("Unable to save gender: \(error)")
        }
    }
    
    func getUserGender() -> String? {
        let users = Table("users")
        let gender = Expression<String>("gender")
        do {
            if let user = try db?.pluck(users) {
                return try user.get(gender)
            } else {
                return nil
            }
        } catch {
            print("Unable to retrieve user gender\(error)")
            return nil
        }
    }
}
